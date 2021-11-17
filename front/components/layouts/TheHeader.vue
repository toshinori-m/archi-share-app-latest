<template>
  <v-app-bar fixed app color="blue-grey lighten-1">
    <v-app-bar-title class="white--text">
      ホーム
    </v-app-bar-title>
    <v-spacer />
    <template v-if="!login">
      <the-sign-up />
      <the-sign-in />
    </template>
  </v-app-bar>
</template>

<script>
import { mapGetters } from 'vuex'
import TheSignUp from '~/components/layouts/TheSignUp.vue'
import TheSignIn from '~/components/layouts/TheSignIn.vue'
export default {
  components: {
    TheSignUp,
    TheSignIn
  },
  computed: {
    ...mapGetters('authentication', [
      'login'
    ])
  }
}
</script>
