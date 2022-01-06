<template>
  <v-card>
    <v-toolbar flat color="tertiary">
      <v-toolbar-title class="mx-auto">
        <span class="headline primary--text">パスワード変更</span>
      </v-toolbar-title>
    </v-toolbar>
    <v-card-text>
      <v-form ref="form">
        <v-text-field
          v-model="password"
          label="新しいパスワード"
          :type="show ? 'text' : 'password'"
           :rules="passwordRules"
          validate-on-blur
          counter
          color="secondary"
          prepend-icon="mdi-lock"
          :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show = !show"
        />
        <v-text-field
          v-model="passwordConfirmation"
          label="新しいパスワード(確認)"
          :type="show2 ? 'text' : 'password'"
          :rules="[passwordConfirmationRules]"
          validate-on-blur
          counter
          color="secondary"
          prepend-icon="mdi-lock"
          :append-icon="show2 ? 'mdi-eye' : 'mdi-eye-off'"
          @click:append="show2 = !show2"
        />
      </v-form>
    </v-card-text>
    <v-card-actions class="pa-4">
      <v-btn
        v-if="currentUser && currentUser.email !== guest"
        block
        color="tertiary"
        class="primary--text"
        @click="userEditAction"
      >
        変更
      </v-btn>
      <v-btn
        v-else
        block
        color="tertiary"
        class="primary--text"
      >
        ゲストユーザーは変更出来ません
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  data() {
    return {
      password: '',
      passwordConfirmation: '',
      show: false,
      show2: false,
      guest: 'guestuser0123@gmail.com',
      passwordRules: [
        v => !!v || 'パスワードを入力してください',
        v => (v && v.length >= 6) || '6文字以上で入力してください'
      ]
    }
  },
  computed: {
    ...mapGetters('authentication', [
      'currentUser'
    ]),
    passwordConfirmationRules() {
      return (this.password === this.passwordConfirmation) || 'パスワードが一致しません'
    }
  },
  methods: {
    ...mapActions('snackbarMessage', [
      'messageShow'
    ]),
    async editPassword() {
      const response = await this.$axios
        .put('/api/v1/auth/password', {
          password: this.password,
          password_confirmation: this.passwordConfirmation
        })
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async userEditPassword() {
      const res = await this.editPassword()
      if (!res) {
        return
      }
      this.password = ''
      this.passwordConfirmation = ''
      this.messageShow({
        message: 'パスワードを変更しました',
        type: 'success',
        status: true
      })
    },
    userEditAction() {
      if (this.$refs.form.validate()) {
        this.userEditPassword()
      }
    }
  }
}
</script>
