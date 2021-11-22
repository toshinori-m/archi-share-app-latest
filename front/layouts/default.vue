<template>
  <v-app>
    <the-navigation-drawer />
    <the-header />
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
  }
}
</script>
