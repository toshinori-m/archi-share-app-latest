<template>
  <div>
    <v-btn icon @click="userSignUpModal(true)">
      <v-icon color="primary">mdi-account-plus</v-icon>
    </v-btn>
    <v-dialog
      v-model="signUpModal"
      :fullscreen="xsDialog"
      :hide-overlay="xsDialog"
      :persistent="!xsDialog"
      width="500px"
    >
      <v-card>
        <v-card-actions class="pa-0">
          <v-spacer />
          <v-btn icon large @click="dialogClose">
            <v-icon>mdi-close</v-icon>
          </v-btn>
        </v-card-actions>
        <v-toolbar dense flat color="tertiary">
          <v-toolbar-title class="primary--text mx-auto">
            ユーザー登録
          </v-toolbar-title>
        </v-toolbar>
        <v-card-text class="pt-6">
          <v-form ref="form">
            <v-text-field
              v-model="user.name"
              label="ニックネーム"
              :rules="nameRules"
              validate-on-blur
              counter="30"
              color="secondary"
              prepend-icon="mdi-lead-pencil"
            />
            <v-text-field
              v-model="user.email"
              label="メールアドレス"
              :rules="emailRules"
              validate-on-blur
              color="secondary"
              prepend-icon="mdi-email"
            />
            <v-text-field
              v-model="user.password"
              label="パスワード"
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
              v-model="user.passwordConfirmation"
              label="パスワード確認"
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
        <v-card-actions class="justify-center px-6 pt-0 pb-6">
          <v-btn
            block
            color="tertiary"
            @click="signUpAction(user)"
          >
            登録
          </v-btn>
        </v-card-actions>
        <v-card-text class="d-flex justify-center align-center">
          <span>既にアカウントを持っている方は</span>
          <v-btn small text color="blue" @click="loginDialog">
            ログイン
          </v-btn>
        </v-card-text>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  data() {
    return {
      user: {
        name: '',
        email: '',
        password: '',
        passwordConfirmation: ''
      },
      show: false,
      show2: false,
      nameRules: [
        v => !!v || '名前を入力してください',
        v => (v && v.length <= 30) || '30文字以内で入力してください'
      ],
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
  computed: {
    ...mapGetters('modal', [
      'signUpModal'
    ]),
    passwordConfirmationRules() {
      return (this.user.password === this.user.passwordConfirmation) || 'パスワードが一致しません'
    },
    xsDialog() {
      if (this.$vuetify.breakpoint.xsOnly) {
        return true
      } else {
        return false
      }
    }
  },
  methods: {
    ...mapActions({
      userSignUp: 'authentication/userSignUp',
      userSignUpModal: 'modal/userSignUpModal',
      userSignInModal: 'modal/userSignInModal'
    }
    ),
    signUpAction(user) {
      if (this.$refs.form.validate()) {
        this.userSignUp(user)
      }
    },
    dialogClose() {
      this.userSignUpModal(false)
      this.$refs.form.reset()
    },
    loginDialog() {
      this.userSignUpModal(false)
      this.$refs.form.reset()
      this.userSignInModal(true)
    }
  }
}
</script>
