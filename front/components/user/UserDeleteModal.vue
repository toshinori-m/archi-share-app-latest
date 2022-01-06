<template>
  <div>
    <v-btn
      v-if="currentUser && currentUser.email !== guest"
      color="error"
      :disabled="disable"
      @click="dialog = true"
    >
      アカウント削除
    </v-btn>
    <v-btn
      v-else
      color="error"
      :disabled="disable"
    >
      ゲストユーザーは削除出来ません
    </v-btn>
    <v-dialog
      v-model="dialog"
      persistent
      width="300px"
      height="400px"
    >
      <v-card>
        <v-card-title class="justify-center">
          <span class="primary--text">
            アカウント削除の確認
          </span>
        </v-card-title>
        <v-card-text class="black--text text-center">
          <p class="primary--text">
            本当にアカウントを削除してもよろしいですか？
          </p>
        </v-card-text>
        <v-card-actions>
          <v-btn
            block
            color="tertiary"
            @click="userDeleteAction"
          >
            はい
          </v-btn>
        </v-card-actions>
        <v-card-actions class="pb-4">
          <v-btn
            block
            color="grey lighten-2"
            @click="dialog = false"
          >
            いいえ
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex'
export default {
  props: {
    disable: {
      type: Boolean,
      required: true
    }
  },
  data() {
    return {
      dialog: false,
      guest: 'guestuser0123@gmail.com'
    }
  },
  computed: {
    ...mapGetters('authentication', [
      'currentUser'
    ])
  },
  methods: {
    ...mapMutations('authentication', [
      'currentUserSet',
      'loginSet'
    ]),
    ...mapActions('snackbarMessage', [
      'messageShow'
    ]),
    async userDelete() {
      const response = await this.$axios
        .delete('/api/v1/auth')
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async userDeleteAction() {
      const res = await this.userDelete()
      if (!res) {
        return
      }
      this.dialog = false
      this.$router.push('/')
      this.loginSet(false)
      this.currentUserSet(null)
      this.messageShow({
        message: 'アカウントを削除しました',
        type: 'success',
        status: true
      })
    }
  }
}
</script>
