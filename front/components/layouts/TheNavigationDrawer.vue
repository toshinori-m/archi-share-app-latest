<template>
  <v-navigation-drawer fixed app mini-variant mini-variant-width="64" color="blue-grey lighten-1">
    <v-list dense navi class="mt-15">
      <template v-if="currentUser">
        <v-list-item>
          <home-button />
        </v-list-item>
        <v-list-item>
          <user-edit-button />
        </v-list-item>
        <v-list-item>
          <the-sign-out />
        </v-list-item>
      </template>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import { mapGetters } from 'vuex'
import HomeButton from '~/components/navigationDrawer/HomeButton.vue'
import UserEditButton from '~/components/navigationDrawer/UserEditButton.vue'
import TheSignOut from '~/components/layouts/TheSignOut.vue'
export default {
  components: {
    HomeButton,
    UserEditButton,
    TheSignOut
  },
  computed: {
    ...mapGetters('authentication', [
      'currentUser'
    ])
  }
}
</script>
