<template>
  <div class="text-center">
    <template v-if="login">
      <template v-if="currentUser.id !== user.id">
        <template v-if="$vuetify.breakpoint.smAndUp">
          <v-btn
            v-if="follow"
            :min-width="btnSize"
            :small="smallIconSize"
            :x-small="xSmallIconSize"
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
            :min-width="btnSize"
            :small="smallIconSize"
            :x-small="xSmallIconSize"
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
        <template v-else>
          <v-btn
            v-if="follow"
            min-width="85"
            x-small
            rounded
            :color="color"
            @click.stop="userUnFollow"
          >
            フォロー中
          </v-btn>
          <v-btn
            v-else
            min-width="85"
            x-small
            rounded
            outlined
            color="blue"
            @click.stop="userFollow"
          >
            <v-icon small>
              mdi-account-plus
            </v-icon>
            フォロー
          </v-btn>
        </template>
      </template>
      <template v-else>
        <v-card flat :width="btnSize">
        </v-card>
      </template>
    </template>
    <template v-else>
      <v-btn
        :min-width="btnSize"
        :small="smallIconSize"
        :x-small="xSmallIconSize"
        rounded
        outlined
        color="blue"
        @click.stop="userLogin"
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
import { mapGetters, mapMutations, mapActions } from 'vuex'
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
    ...mapGetters({
      login: 'authentication/login',
      currentUser: 'authentication/currentUser',
      pageUser: 'user/user'
    }),
    loginCheck() {
      return this.currentUser
    },
    btnSize() {
      if (this.$vuetify.breakpoint.mdAndUp) {
        return 125
      } else if (this.$vuetify.breakpoint.smOnly) {
        return 105
      } else {
        return 85
      }
    },
    smallIconSize() {
      if (this.$vuetify.breakpoint.smOnly) {
        return true
      } else {
        return false
      }
    },
    xSmallIconSize() {
      if (this.$vuetify.breakpoint.xsOnly) {
        return true
      } else {
        return false
      }
    }
  },
  watch: {
    loginCheck() {
      if (this.login) {
        const data = this.currentUser.followings.findIndex(n => n.id === this.user.id)
        if (data !== -1) {
          this.follow = true
        } else {
          this.follow = false
        }
      } else {
        this.follow = false
      }
    }
  },
  mounted() {
    if (this.login) {
      const data = this.currentUser.followings.findIndex(n => n.id === this.user.id)
      if (data !== -1) {
        this.follow = true
      }
    }
  },
  methods: {
    ...mapMutations('authentication', [
      'currentUserSet'
    ]),
    ...mapActions({
      userGet: 'user/userGet',
      messageShow: 'snackbarMessage/messageShow',
      userSignInModal: 'modal/userSignInModal'
    }),
    mouseover() {
      this.color = 'red white--text'
      this.message = 'フォロー解除'
    },
    mouseleave() {
      this.color = 'blue white--text'
      this.message = 'フォロー中'
    },
    userLogin() {
      this.userSignInModal(true)
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
      this.currentUserSet(res.data)
      if (this.pageUser) {
        this.userGet(this.pageUser.id)
      }
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
      this.currentUserSet(res.data)
      if (this.pageUser) {
        this.userGet(this.pageUser.id)
      }
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
