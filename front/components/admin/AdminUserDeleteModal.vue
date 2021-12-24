<template>
  <div v-if="currentUser.id !== user.id">
    <v-btn icon color="error" @click.stop="dialog = true">
      <v-icon>
        mdi-delete
      </v-icon>
    </v-btn>
    <v-dialog v-model="dialog" persistent width="400">
      <v-card>
        <v-card-title class="justify-center">
            <span class="primary--text">
              ユーザー削除の確認
            </span>
          </v-card-title>
          <v-card-text class="black--text text-center">
            <p class="primary--text">
              本当にユーザーを削除してもよろしいですか？
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
      dialog: false
    }
  },
  computed: {
    ...mapGetters('authentication', [
      'currentUser'
    ])
  },
  methods: {
    ...mapActions('snackbarMessage', [
      'messageShow'
    ]),
    async userDelete() {
      const response = await this.$axios
        .delete(`/api/v1/users/${this.user.id}`)
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
      this.$emit('load')
      this.messageShow({
        message: 'アカウントを削除しました',
        type: 'success',
        status: true
      })
    }
  }
}
</script>
