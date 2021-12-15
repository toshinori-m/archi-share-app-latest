<template>
  <v-navigation-drawer
    fixed
    app
    mini-variant
    mini-variant-width="64"
    color="blue-grey lighten-1"
  >
    <v-list dense navi>
      <template v-if="currentUser">
        <v-list-item>
          <v-list-item-avatar>
            <current-user-icon />
          </v-list-item-avatar>
        </v-list-item>
        <v-list-item>
          <home-button />
        </v-list-item>
        <v-list-item>
          <post-create-button />
        </v-list-item>
        <v-list-item>
          <post-search-button />
        </v-list-item>
        <v-list-item>
          <user-search-button />
        </v-list-item>
        <v-list-item>
          <user-edit-button />
        </v-list-item>
        <v-list-item>
          <the-sign-out />
        </v-list-item>
      </template>
      <template v-else>
        <v-list-item class="mt-15">
          <home-button />
        </v-list-item>
        <v-list-item>
          <user-search-button />
        </v-list-item>
      </template>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import { mapGetters } from 'vuex'
import currentUserIcon from '~/components/navigationDrawer/CurrentUserIcon.vue'
import HomeButton from '~/components/navigationDrawer/HomeButton.vue'
import PostCreateButton from '~/components/navigationDrawer/PostCreateButton.vue'
import PostSearchButton from '~/components/navigationDrawer/PostSearchButton.vue'
import UserSearchButton from '~/components/navigationDrawer/UserSearchButton.vue'
import UserEditButton from '~/components/navigationDrawer/UserEditButton.vue'
import TheSignOut from '~/components/layouts/TheSignOut.vue'
export default {
  components: {
    currentUserIcon,
    HomeButton,
    PostCreateButton,
    PostSearchButton,
    UserSearchButton,
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
