<template>
  <v-app-bar app flat color="white">
    <v-app-bar-nav-icon :class="[login ? '' : 'mr-13']" @click="drawerSet" />
    <v-spacer />
    <span class="text-md-h5 primary--text text-truncate">{{ title }}</span>
    <v-spacer />
    <template v-if="login">
      <the-sign-out />
    </template>
    <template v-else>
      <the-sign-up />
      <the-sign-in />
    </template>
  </v-app-bar>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import TheSignUp from '~/components/layouts/TheSignUp.vue'
import TheSignIn from '~/components/layouts/TheSignIn.vue'
import TheSignOut from '~/components/layouts/TheSignOut.vue'
export default {
  components: {
    TheSignUp,
    TheSignIn,
    TheSignOut
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
      } else if (title === 'ホーム') {
        return 'ArchiShare'
      } else {
        return headInfo.title
      }
    }
  },
  methods: {
    ...mapMutations('navigationDrawer', [
      'drawerSet'
    ])
  }
}
</script>
