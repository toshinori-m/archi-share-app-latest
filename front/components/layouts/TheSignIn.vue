<template>
  <div>
    <v-btn icon @click="dialog = true">
      <v-icon color="white">mdi-login</v-icon>
    </v-btn>
    <v-dialog v-model="dialog" persistent width="500px">
      <v-card>
        <v-card-actions class="pb-0">
          <v-spacer />
          <v-btn icon large @click="dialogClose">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-card-actions>
        <v-card-title class="justify-center pa-0">
          <span class="text-h5 text-weight-bold">
            ユーザーログイン
          </span>
        </v-card-title>
        <v-card-text class="pt-6">
          <v-form ref="form">
            <v-text-field
              v-model="user.email"
              label="メールアドレス"
              :rules="emailRules"
              validate-on-blur
              prepend-icon="mdi-email"
            />
            <v-text-field
              v-model="user.password"
              label="パスワード"
              :type="show ? 'text' : 'password'"
              :rules="passwordRules"
              validate-on-blur
              prepend-icon="mdi-lock"
              :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
              @click:append="show = !show"
            />
          </v-form>
        </v-card-text>
        <v-card-actions class="justify-center px-6 pt-0 pb-6">
          <v-btn
            block
            color="light-blue lighten-2"
            @click="signInAction(user)"
          >
            ログイン
          </v-btn>
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
      dialog: false,
      user: {
        email: '',
        password: ''
      },
      show: false,
      emailRules: [
        v => !!v || 'メールアドレスを入力してください',
        v => /.+@.+\..+/.test(v) || '正しいメールアドレスを入力してください'
      ],
      passwordRules: [
        v => !!v || 'パスワードを入力してください',
        v => (v && v.length >= 6) || '6文字以上で入力してください'
      ]
    }
  },
  methods: {
    ...mapActions('authentication', [
      'userSignIn'
    ]),
    dialogClose() {
      this.dialog = false
      this.$refs.form.reset()
    },
    signInAction(user) {
      if (this.$refs.form.validate()) {
        this.userSignIn(user)
        this.dialog = false
      }
    }
  }
}
</script>
