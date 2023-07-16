<template>
  <v-app>
    <v-layout>
      <v-app-bar
        color="primary"
        density="compact">
        <v-app-bar-title>AI-CODE-DOCTOR</v-app-bar-title>
      </v-app-bar>
      <v-main>
        <CreateTestCode/>
      </v-main>
    </v-layout>
  </v-app>
</template>

<script lang="ts">
import { defineComponent } from 'vue'
import CreateTestCode from './components/CreateTestCode.vue'

export default defineComponent({
  name: 'App',

  components: {
    CreateTestCode,
  },

  data () {
    return {
      //
    }
  },
})
</script>
