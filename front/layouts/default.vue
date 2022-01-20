<template>
  <v-app>
    <v-navigation-drawer
      v-model="drawer"
      app
      temporary
    >
      <the-navigation-drawer />
    </v-navigation-drawer>
    <v-app-bar
      app
      flat
      color="white"
    >
      <v-app-bar-nav-icon
        :class="[login ? '' : 'mr-13']"
        @click="drawer = !drawer"
      />
      <v-spacer />
      <span
        class="text-md-h5
        primary--text
        text-truncate"
      >
        {{ title }}
      </span>
      <v-spacer />
      <template v-if="login">
        <the-sign-out />
      </template>
      <template v-else>
        <the-sign-up />
        <the-sign-in />
      </template>
    </v-app-bar>
    <v-main>
      <the-snackbar v-if="$vuetify.breakpoint.smAndUp" />
      <the-progress-linear />
      <v-container>
        <Nuxt />
      </v-container>
    </v-main>
    <the-footer />
  </v-app>
</template>

<script>
import { mapGetters } from 'vuex'
import TheNavigationDrawer from '~/components/layouts/TheNavigationDrawer.vue'
import TheSignUp from '~/components/layouts/TheSignUp.vue'
import TheSignIn from '~/components/layouts/TheSignIn.vue'
import TheSignOut from '~/components/layouts/TheSignOut.vue'
import TheSnackbar from '~/components/layouts/TheSnackbar.vue'
import TheProgressLinear from '~/components/layouts/TheProgressLinear.vue'
import TheFooter from '~/components/layouts/TheFooter.vue'
export default {
  components: {
    TheNavigationDrawer,
    TheSignUp,
    TheSignIn,
    TheSignOut,
    TheSnackbar,
    TheProgressLinear,
    TheFooter
  },
  data() {
    return {
      drawer: false
    }
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
  }
}
</script>
