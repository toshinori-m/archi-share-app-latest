<template>
  <v-app-bar fixed app color="blue-grey lighten-1">
    <span class="white--text text-h6">{{ title }}</span>
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
    ...mapGetters({
      login: 'authentication/login',
      user: 'user/user'
    }),
    title() {
      const matchedRoute = this.$route.matched[0]
      const headInfo = matchedRoute.components.default.options.head()
      const title = headInfo.title
      if (title === undefined) {
        return this.user.name
      } else {
        return headInfo.title
      }
    }
  }
}
</script>
