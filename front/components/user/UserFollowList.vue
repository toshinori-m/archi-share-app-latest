<template>
  <v-card>
    <v-card-actions>
      <v-spacer />
      <v-btn
        icon
        large
        @click="closeDialog"
      >
        <v-icon>
          mdi-close
        </v-icon>
      </v-btn>
    </v-card-actions>
    <v-tabs
      v-model="tab"
      grow
      color="primary"
    >
      <v-tab v-for="item in items" :key="item">
        {{ item }}
      </v-tab>
    </v-tabs>
    <v-tabs-items v-model="tab">
      <v-tab-item>
        <v-card>
          <v-list v-if="followings[0]">
            <v-list-item
              v-for="following in followings"
              :key="following.id"
              @click="userClick(following)"
            >
              <v-list-item-avatar :size="avatarSize">
                <v-img v-if="following.image.url" :src="following.image.url" />
                <v-img v-else :src="icon" />
              </v-list-item-avatar>
              <v-list-item-content>
                <span
                  class="text-xs-caption
                  text-sm-subtitle1
                  text-truncate"
                >
                  {{ following.name }}
                </span>
              </v-list-item-content>
              <v-list-item-action>
                <user-follow-button :user="following" />
              </v-list-item-action>
            </v-list-item>
          </v-list>
          <v-card-text v-else class="text-h6 text-center">
            {{ user.name }}がフォローしているユーザーはいません
          </v-card-text>
        </v-card>
      </v-tab-item>
      <v-tab-item>
        <v-card>
          <v-list v-if="followers[0]">
            <v-list-item
              v-for="follower in followers"
              :key="follower.id"
              @click="userClick(follower)"
            >
              <v-list-item-avatar :size="avatarSize">
                <v-img v-if="follower.image.url" :src="follower.image.url" />
                <v-img v-else :src="icon" />
              </v-list-item-avatar>
              <v-list-item-content>
                <span
                  class="text-xs-caption
                  text-sm-subtitle1
                  text-truncate"
                >
                  {{ follower.name }}
                </span>
              </v-list-item-content>
              <v-list-item-action>
                <user-follow-button :user="follower" />
              </v-list-item-action>
            </v-list-item>
          </v-list>
          <v-card-text v-else class="text-h6 text-center">
            {{ user.name }}をフォローしているユーザーはいません
          </v-card-text>
        </v-card>
      </v-tab-item>
    </v-tabs-items>
  </v-card>
</template>

<script>
import { mapGetters }  from 'vuex'
import UserFollowButton from '~/components/user/UserFollowButton.vue'
export default {
  components: {
    UserFollowButton
  },
  filters: {
    filteredName(name) {
      return name.length > 10 ? name.slice(0, 10) + '...' : name
    }
  },
  props: {
    followings: {
      type: Array,
      required: true
    },
    followers: {
      type: Array,
      required: true
    },
    tabs: {
      type: Boolean,
      required: true
    }
  },
  data() {
    return {
      icon: require('@/assets/images/default.png'),
      tab: null,
      items: [
        'フォロー', 'フォロワー'
      ]
    }
  },
  computed: {
    ...mapGetters('user', [
      'user'
    ]),
    avatarSize() {
      if (this.$vuetify.breakpoint.smAndUp) {
        return 60
      } else {
        return 45
      }
    }
  },
  mounted() {
    if (this.tabs) {
      this.tab = 1
    } else {
      this.tab = 0
    }
  },
  methods: {
    closeDialog() {
      this.$emit('close')
    },
    userClick(f) {
      this.$router.push(`/users/${f.id}`)
    }
  }
}
</script>
