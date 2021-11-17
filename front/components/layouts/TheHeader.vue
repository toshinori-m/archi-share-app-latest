<template>
  <v-app-bar fixed app color="blue-grey lighten-1">
    <v-app-bar-title class="white--text">
      ホーム
    </v-app-bar-title>
    <v-spacer />
    <the-sign-up />
  </v-app-bar>
</template>

<script>
import TheSignUp from '~/components/layouts/TheSignUp.vue'
export default {
  components: {
    TheSignUp
  }
}
</script>
