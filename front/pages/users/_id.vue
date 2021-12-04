<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="9" md="7">
      <v-card tile outlined>
        <div class="d-flex justify-space-between pt-4">
          <v-avatar size="100" class="ma-4">
            <v-img v-if="user.image.url" :src="user.image.url" />
            <v-img v-else :src="icon" />
          </v-avatar>
          <user-follow-count
            :followings="user.followings"
            :followers="user.followers"
          />
          <user-follow-button
            :user="user"
            class="mr-4"
          />
        </div>
        <v-card-text class="pt-0 text--primary">
          <p class="text-h6">{{ user.name }}</p>
          <p>{{ user.introduction }}</p>
        </v-card-text>
        <v-card-actions
          v-if="user.id == currentUser.id"
          class="justify-end pa-4 pt-0"
        >
          <v-btn outlined @click="userEditButton">
            ユーザー情報を編集
          </v-btn>
        </v-card-actions>
      </v-card>
      <v-tabs v-model="tab" fixed-tabs>
        <v-tab>
          投稿
        </v-tab>
        <v-tab>
          いいね
        </v-tab>
      </v-tabs>
      <user-post-list v-if="tab == 0" :user="user" />
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import UserFollowButton from '~/components/user/UserFollowButton.vue'
import UserFollowCount from '~/components/user/UserFollowCount.vue'
import UserPostList from '~/components/user/UserPostList.vue'
export default {
  components: {
    UserFollowButton,
    UserFollowCount,
    UserPostList
  },
  data() {
    return {
      title: '',
      icon: require('@/assets/images/default.png'),
      tab: null
    }
  },
  async fetch({ $axios, params, store }) {
    await $axios
      .$get(`/api/v1/users/${params.id}`)
      .then((res) => {
        store.commit('user/userSet', res)
      })
      .catch((e) => {
        console.log(e)
      })
  },
  head() {
    return {
      title: this.title
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser',
      user: 'user/user'
    }),
    currentUserCheck() {
      return this.currentUser
    }
  },
  watch: {
    currentUserCheck() {
      this.userGet(this.user.id)
    }
  },
  created() {
    this.title = this.user.name
  },
  methods: {
    ...mapActions('user', [
      'userGet'
    ]),
    userEditButton() {
      this.$router.push('/users/edit')
    }
  }
}
</script>
