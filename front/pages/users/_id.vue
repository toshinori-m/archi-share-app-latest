<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="10" md="10" lg="8">
      <v-card tile>
        <div class="pt-4">
          <v-row dense justify="center" algin="center">
            <v-col cols="4">
              <v-avatar
                v-if="$vuetify.breakpoint.mdAndUp"
                size="100"
                class="ma-2 ml-4"
              >
                <v-img v-if="user.image.url" :src="user.image.url" />
                <v-img v-else :src="icon" />
              </v-avatar>
              <v-avatar
                v-else
                size="60"
                class="ma-2 ml-4"
              >
                <v-img v-if="user.image.url" :src="user.image.url" />
                <v-img v-else :src="icon" />
              </v-avatar>
            </v-col>
            <v-col cols="4">
              <user-follow-count
                :followings="user.followings"
                :followers="user.followers"
              />
            </v-col>
            <v-col cols="4">
              <user-follow-button
                :user="user"
              />
            </v-col>
          </v-row>
        </div>
        <v-card-text class="pt-0 text--primary">
          <p class=" text-h6">{{ user.name }}</p>
          <p>{{ user.introduction }}</p>
        </v-card-text>
        <template v-if="login">
          <v-card-actions
            v-if="user.id == currentUser.id"
            class="justify-end pa-4 pt-0"
          >
            <v-btn
              outlined
              color="primary"
              @click="userEditButton"
            >
              ユーザー情報を編集
            </v-btn>
          </v-card-actions>
        </template>
      </v-card>
      <v-tabs v-model="tab" dark fixed-tabs background-color="primary">
        <v-tab>
          投稿
        </v-tab>
        <v-tab>
          いいね
        </v-tab>
      </v-tabs>
      <user-post-list
        v-if="tab == 0"
        :user="user"
        :posts="userPost"
      />
      <like-post-list
        v-else
        :user="user"
        :posts="userLikePost"
      />
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import UserFollowButton from '~/components/user/UserFollowButton.vue'
import UserFollowCount from '~/components/user/UserFollowCount.vue'
import UserPostList from '~/components/user/UserPostList.vue'
import LikePostList from '~/components/like/LikePostList.vue'
export default {
  components: {
    UserFollowButton,
    UserFollowCount,
    UserPostList,
    LikePostList
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
        store.commit('user/userPostSet', res.posts)
        store.commit('user/userLikePostSet', res.postlike)
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
      login: 'authentication/login',
      user: 'user/user',
      post: 'post/post',
      userPost: 'user/userPost',
      userLikePost: 'user/userLikePost'
    }),
    postCheck() {
      return this.post
    },
    tabCheck() {
      return this.tab
    }
  },
  watch: {
    postCheck() {
      if (this.tab === 1) {
        this.userLikePostUpdate(this.post)
      } else {
        this.userPostUpdate(this.post)
      }
    },
    tabCheck() {
      if (this.tab === 0) {
        this.$axios
          .get(`/api/v1/users/${this.user.id}`)
          .then((res) => {
            this.userLikePostSet(res.data.postlike)
          })
          .catch((e) => {
            console.log(e)
          })
      }
    }
  },
  created() {
    this.title = this.user.name
  },
  methods: {
    ...mapMutations('user', [
      'userLikePostSet',
      'userPostUpdate',
      'userLikePostUpdate'
    ]),
    userEditButton() {
      this.$router.push('/users/edit')
    }
  }
}
</script>
