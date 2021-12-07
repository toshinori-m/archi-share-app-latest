<template>
  <div v-if="login" class="d-flex">
    <span class="d-flex align-center text-h6">
      {{ post.like_users.length }}
    </span>
    <v-btn
      v-if="like"
      icon
      color="pink"
      @click.stop="userUnLikePost"
    >
      <v-icon>
        mdi-heart
      </v-icon>
    </v-btn>
    <v-btn
      v-else
      icon
      @click.stop="userLikePost"
    >
      <v-icon>
        mdi-heart
      </v-icon>
    </v-btn>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex'
export default {
  props: {
    post: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      like: false
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser',
      login: 'authentication/login'
    })
  },
  mounted() {
    if (this.login) {
      this.post.like_users.forEach((f) => {
        if (this.currentUser.id === f.id) {
          this.like = true
        }
      })
    }
  },
  methods: {
    ...mapMutations('post', [
      'postSet'
    ]),
    ...mapActions({
      currentUserInfo: 'authentication/currentUserInfo',
      postGet: 'post/postGet',
      messageShow: 'snackbarMessage/messageShow'
    }),
    async likePost() {
      const response = await this.$axios
        .post('/api/v1/post_likes', {
          user_id: this.currentUser.id,
          post_id: this.post.id
        })
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async unLikePost() {
      const response = await this.$axios
        .delete('/api/v1/post_likes', {
          params: {
            user_id: this.currentUser.id,
            post_id: this.post.id
          }
        })
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async userLikePost() {
      const res = await this.likePost()
      if (!res) {
        return
      }
      // this.currentUserInfo(this.currentUser)
      this.postSet(res.data)
      this.like = true
      this.messageShow({
        message: '投稿をいいねしました',
        type: 'success',
        status: true
      })
    },
    async userUnLikePost() {
      const res = await this.unLikePost()
      if (!res) {
        return
      }
      // this.currentUserInfo(this.currentUser)
      this.postSet(res.data)
      this.like = false
      this.messageShow({
        message: '投稿のいいねを外しました',
        type: 'info',
        status: true
      })
    }
  }
}
</script>
