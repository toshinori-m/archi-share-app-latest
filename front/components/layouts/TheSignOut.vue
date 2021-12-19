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
          <span>ログアウトの確認</span>
        </v-card-title>
        <v-card-text class="black--text text-center">
          <p>ログアウトしてもよろしいですか？</p>
        </v-card-text>
        <v-card-actions>
          <v-btn block color="light-blue lighten-2" @click="signOutAction">はい</v-btn>
        </v-card-actions>
        <v-card-actions class="pb-4">
          <v-btn block @click="dialog = false">いいえ</v-btn>
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
      if (title === 'ホーム' || title === 'ユーザー検索' || title === '投稿検索') {
        this.dialog = false
        this.userSignOut()
      } else {
        this.$router.push('/')
        this.dialog = false
        this.userSignOut()
      }
    }
  }
}
</script>
