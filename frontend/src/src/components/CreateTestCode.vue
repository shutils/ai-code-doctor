<template>
  <v-container>
    <v-text-field
      v-for="(condition, index) in conditions"
      :key="index"
      v-model="conditions[index]"
      label="Condition"
      class="mb-4"
      hide-details="auto">
    </v-text-field>
    <v-btn @click="addConditions" class="mr-4">条件を追加</v-btn>
    <v-btn @click="removeConditions">条件を削除</v-btn>
    <v-textarea
      v-model="method"
      label="関数を入力"
      class="mt-4"
      auto-grow>
    </v-textarea>
    <v-btn @click="fetchMessage">送信</v-btn>
    <div v-html="answer_preview"></div>
  </v-container>
</template>

<script lang='ts'>
import { defineComponent } from 'vue'
import axios from 'axios'

// Logo
import logo from '../assets/logo.svg'
import MarkdownIt from 'markdown-it'
const markdown = new MarkdownIt()

export default defineComponent({
  name: 'CreateTestCode',

  data () {
    return {
      conditions: [""],
      answer: "",
      answer_preview: "",
      method: "",
    }
  },
  methods: {
    addConditions() {
      this.conditions.push("");
    },
    removeConditions() {
      this.conditions.splice(this.conditions.length - 1, 1);
    },
    async fetchMessage() {
      const me = this
      me.answer = ""
      const regex = /data:\s*({.*?})(?=\s*data:|$)/gs;
      await fetch(window.location.href + 'api/process_request', {
        method: "POST",
        body: JSON.stringify({
          conditions: this.conditions,
          method: this.method
        }),
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
      })
      .then((res) => {
        const reader = res.body.getReader();
        const decoder = new TextDecoder();
        async function processStream({ done, value }) {
          if (done) {
            console.log('streaming end');
            return;
          }
          const jsonData = [];
          let match;

          const chunk = decoder.decode(value);

          while ((match = regex.exec(chunk)) !== null) {
            jsonData.push(JSON.parse(match[1]));
          }

          for (const v of jsonData) {
            await console.log(v)
            if (v.choices[0].delta.content !== undefined) {
              me.answer += v.choices[0].delta.content
              me.answer_preview = markdown.render(me.answer)
            }
          }

          // await console.log(chunk);

          return reader.read().then(processStream);
        }
        return reader.read().then(processStream);
      })
      .catch(error => {
        console.error('error', error);
      })
    },
    sendMessage() {
      axios({
        method: 'post',
        url: window.location.href + 'api/process_request',
        headers: {
          'Content-Type': 'application/json',
          'Access-Control-Allow-Origin': '*',
        },
        data: {
          conditions: this.conditions,
          method: this.method,
        }
      })
      .then((res) => {
        console.log(res.data)
        this.answer = markdown.render(res.data.choices[0].message.content)
      })
    }
  },
})
</script>
