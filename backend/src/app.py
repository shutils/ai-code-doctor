import os
from flask import Flask, request
import requests
import json

app = Flask(__name__)

API_KEY = os.environ["OPENAI_API_KEY"]


@app.route('/process_request', methods=['POST'])
def process_request():
    # フロントエンドからのリクエストデータを取得する
    data = request.json

    # ChatGPTのAPIにリクエストを送信する
    api_url = 'https://api.openai.com/v1/chat/completions'  # ChatGPTのAPIのURLに置き換えてください
    headers = {
        'Content-Type': 'application/json',
        'Authorization': f"Bearer {API_KEY}",
    }
    messages = [
        {
            "role": "system",
            "content": "あなたはユーザーから渡された関数をテストするプログラマーです。",
        },
        {
            "role": "system",
            "content": "ユーザーからいくつかの条件が渡されるので、それらを満たすテストコードを作成します。",
        },
        {
            "role": "system",
            "content": "解答は必ず日本語で行ってください",
        },
    ]
    messages.append({
            "role": "user",
            "content": "条件は以下の通りです",
        })
    for condition in data.get("conditions"):
        messages.append({
            "role": "user",
            "content": condition,
        })
    messages.append({
            "role": "user",
            "content": "関数は以下の通りです",
        })
    messages.append({
            "role": "user",
            "content": data.get("method"),
        })
    payload = {
        "model": "gpt-3.5-turbo-16k",
        "messages": messages,
        "max_tokens": 4000,
        "temperature": 0.9,
    }
    response = requests.post(api_url, json=payload, headers=headers)
    app.logger.error(response.text)

    # APIのレスポンスをフロントエンドに返す
    return response.json()


if __name__ == '__main__':
    app.run()
