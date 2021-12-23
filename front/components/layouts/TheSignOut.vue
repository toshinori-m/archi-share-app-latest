<template>
  <div>
    <v-btn
      icon
      large
      @click="dialog = true"
    >
      <v-icon color="primary">mdi-logout</v-icon>
    </v-btn>
    <v-dialog
      v-model="dialog"
      persistent
      width="300px"
      height="400px"
    >
      <v-card>
        <v-card-title class="justify-center">
          <span class="primary--text">ログアウトの確認</span>
        </v-card-title>
        <v-card-text class="primary--text text-center">
          <p>ログアウトしてもよろしいですか？</p>
        </v-card-text>
        <v-card-actions>
          <v-btn block color="tertiary" @click="signOutAction">はい</v-btn>
        </v-card-actions>
        <v-card-actions class="pb-4">
          <v-btn block color="grey lighten-2" @click="dialog = false">いいえ</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  data() {
    return {
      dialog: false
    }
  },
  methods: {
    ...mapActions('authentication', [
      'userSignOut'
    ]),
    signOutAction() {
      const matchedRoute = this.$route.matched[0]
      const headInfo = matchedRoute.components.default.options.head()
      const title = headInfo.title
      if (title === '新規投稿' || title === 'アカウント編集') {
        this.$router.push('/')
        this.dialog = false
        this.userSignOut()
      } else {
        this.dialog = false
        this.userSignOut()
      }
    }
  }
}
</script>
