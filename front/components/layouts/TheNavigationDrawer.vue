<template>
  <v-navigation-drawer fixed app mini-variant mini-variant-width="70" color="blue-grey lighten-1">
    <v-list dense navi>
      <v-list-item class="mt-15">
        <the-sign-out v-if="currentUser" />
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import { mapGetters } from 'vuex'
import TheSignOut from '~/components/layouts/TheSignOut.vue'
export default {
  components: {
    TheSignOut
  },
  computed: {
    ...mapGetters('authentication', [
      'currentUser'
    ])
  }
}
</script>
