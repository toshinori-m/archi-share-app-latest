<template>
  <v-app-bar fixed app color="blue-grey lighten-1">
    <v-app-bar-title class="white--text">
      ホーム
    </v-app-bar-title>
    <v-spacer />
    <the-sign-up />
    <the-sign-in />
  </v-app-bar>
</template>

<script>
import TheSignUp from '~/components/layouts/TheSignUp.vue'
import TheSignIn from '~/components/layouts/TheSignIn.vue'
export default {
  components: {
    TheSignUp,
    TheSignIn
  }
}
</script>
