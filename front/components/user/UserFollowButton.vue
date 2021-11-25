<template>
  <div v-if="login">
    <template v-if="currentUser.id !== user.id">
      <v-btn
        v-if="follow"
        min-width="125"
        rounded
        :color="color"
        @click.stop="userUnFollow"
        @mouseover="mouseover"
        @mouseleave="mouseleave"
      >
        {{ message }}
      </v-btn>
      <v-btn
        v-else
        min-width="125"
        rounded
        outlined
        color="blue"
        @click.stop="userFollow"
      >
        <v-icon>
          mdi-account-plus
        </v-icon>
        フォロー
      </v-btn>
    </template>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  props: {
    user: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      follow: false,
      message: 'フォロー中',
      color: 'blue white--text'
    }
  },
  computed: {
    ...mapGetters('authentication', [
      'login',
      'currentUser'
    ])
  },
  mounted() {
    if (this.login) {
      this.currentUser.followings.forEach((f) => {
        if (this.user.id === f.id) {
          this.follow = true
        }
      })
    }
  },
  methods: {
    ...mapActions({
      userGet: 'user/userGet',
      currentUserInfo: 'authentication/currentUserInfo',
      messageShow: 'snackbarMessage/messageShow'
    }),
    mouseover() {
      this.color = 'red white--text'
      this.message = 'フォロー解除'
    },
    mouseleave() {
      this.color = 'blue white--text'
      this.message = 'フォロー中'
    },
    async followButton() {
      const response = await this.$axios
        .post('/api/v1/relationships', {
          user_id: this.currentUser.id,
          follow_id: this.user.id
        })
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async unFollowButton() {
      const response = await this.$axios
        .delete('/api/v1/relationships', {
          params: {
            user_id: this.currentUser.id,
            follow_id: this.user.id
          }
        })
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async userFollow() {
      const res = await this.followButton()
      if (!res) {
        return
      }
      this.currentUserInfo(this.currentUser)
      this.follow = true
      this.messageShow({
        message: 'フォローしました',
        type: 'success',
        status: true
      })
    },
    async userUnFollow() {
      const res = await this.unFollowButton()
      if (!res) {
        return
      }
      this.currentUserInfo(this.currentUser)
      this.follow = false
      this.messageShow({
        message: 'フォロー解除しました',
        type: 'success',
        status: true
      })
    }
  }
}
</script>
