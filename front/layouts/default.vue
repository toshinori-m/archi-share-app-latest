<template>
  <v-app>
    <the-navigation-drawer />
    <the-header :title="title" />
    <v-main>
      <the-snackbar />
      <v-container>
        <Nuxt />
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import TheNavigationDrawer from '~/components/layouts/TheNavigationDrawer.vue'
import TheHeader from '~/components/layouts/TheHeader.vue'
import TheSnackbar from '~/components/layouts/TheSnackbar.vue'
export default {
  components: {
    TheHeader,
    TheNavigationDrawer,
    TheSnackbar
  },
  computed: {
    title() {
      const matchedRoute = this.$route.matched[0]
      const headInfo = matchedRoute.components.default.options.head()
      return headInfo ? headInfo.title : ''
    }
  }
}
</script>
