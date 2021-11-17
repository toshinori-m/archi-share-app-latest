<template>
  <v-app>
    <the-header />
    <v-main>
      <v-container>
        <Nuxt />
      </v-container>
    </v-main>
  </v-app>
</template>

<script>
import TheHeader from '~/components/layouts/TheHeader.vue'
export default {
  components: {
    TheHeader
  }
}
</script>
