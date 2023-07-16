<template>
  <v-container>
    <v-text-field
      v-for="(condition, index) in conditions"
      :key="index"
      v-model="conditions[index]"
      label="Condition"
      hide-details="auto">
    </v-text-field>
    <v-btn @click="addConditions">条件を追加</v-btn>
    <v-textarea
      v-model="method"
      label="関数を入力"
      auto-grow>
    </v-textarea>
    <v-btn @click="sendMessage">送信</v-btn>
    <div v-html="answer"></div>
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
      method: "",
    }
  },
  methods: {
    addConditions() {
      this.conditions.push("");
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
