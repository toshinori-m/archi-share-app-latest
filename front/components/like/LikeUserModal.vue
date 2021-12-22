<template>
  <div>
    <v-btn
      icon
      large
      @click="dialog = true"
    >
      <v-icon>
        mdi-account-heart
      </v-icon>
    </v-btn>
    <v-dialog v-model="dialog" :fullscreen="fullscreen" persistent width="500px">
      <v-card>
        <v-card-actions class="pa-0">
          <v-spacer />
          <v-btn
            icon
            large
            @click="dialog = false"
          >
            <v-icon>
              mdi-close
            </v-icon>
          </v-btn>
        </v-card-actions>
        <!-- <v-card-title class="justify-center">
          <span class="headline">いいねしたユーザー</span>
        </v-card-title> -->
        <v-toolbar dense flat color="tertiary">
          <v-toolbar-title class="text-subtitle-1 mx-auto">
            いいねしたユーザー
          </v-toolbar-title>
        </v-toolbar>
        <template v-if="users[0]">
          <v-list>
            <v-list-item
              v-for="user in users"
              :key="user.id"
              @click="userClick(user)"
            >
              <v-list-item-avatar :size="avatarSize">
                <v-img v-if="user.image.url" :src="user.image.url" />
                <v-img v-else :src="icon" />
              </v-list-item-avatar>
              <v-list-item-content>
                <span
                  class="text-xs-caption
                  text-sm-subtitle1
                  text-truncate"
                >
                  {{ user.name }}
                </span>
              </v-list-item-content>
              <v-list-item-action>
                <user-follow-button :user="user" />
              </v-list-item-action>
            </v-list-item>
          </v-list>
        </template>
        <template v-else>
          <v-card-text>
            <p class="text-h5 text-center mt-4 mb-0">投稿をいいねしたユーザーはいません</p>
          </v-card-text>
        </template>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import UserFollowButton from '~/components/user/UserFollowButton.vue'
export default {
  components: {
    UserFollowButton
  },
  props: {
    users: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      dialog: false,
      icon: require('@/assets/images/default.png')
    }
  },
  computed: {
    fullscreen() {
      if (this.$vuetify.breakpoint.xsOnly) {
        return true
      } else {
        return false
      }
    },
    avatarSize() {
      if (this.$vuetify.breakpoint.smAndUp) {
        return 60
      } else {
        return 45
      }
    }
  },
  methods: {
    userClick(user) {
      this.$router.push(`/users/${user.id}`)
    }
  }
}
</script>
