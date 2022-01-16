<template>
  <div>
    <v-btn icon @click="userSignInModal(true)">
      <v-icon color="primary">mdi-login</v-icon>
    </v-btn>
    <v-dialog
      v-model="signInModal"
      :fullscreen="xsDialog"
      :hide-overlay="xsDialog"
      :persistent="!xsDialog"
      width="500"
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
            ユーザーログイン
          </v-toolbar-title>
        </v-toolbar>
        <v-card-text class="pt-6">
          <v-form ref="form">
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
              color="secondary"
              prepend-icon="mdi-lock"
              :append-icon="show ? 'mdi-eye' : 'mdi-eye-off'"
              @click:append="show = !show"
            />
          </v-form>
        </v-card-text>
        <v-card-actions class="justify-center px-6 pt-0">
          <v-btn
            block
            color="tertiary"
            class="primary--text"
            @click="signInAction(user)"
          >
            ログイン
          </v-btn>
        </v-card-actions>
        <v-card-actions class="justify-center px-6 pt-0 pb-6">
          <v-btn
            block
            color="accent"
            class="primary--text"
            @click="guestSignIn"
          >
            ゲストログイン
          </v-btn>
        </v-card-actions>
        <v-card-text class="d-flex justify-center align-center">
          <span>アカウントをまだ持っていない方は</span>
          <v-btn small text color="blue" @click="newDialog">
            新規登録
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
        email: '',
        password: ''
      },
      guest: {
        email: 'guestuser0123@gmail.com',
        password: 'guestuser0123'
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
  computed: {
    ...mapGetters('modal', [
      'signInModal'
    ]),
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
      userSignIn: 'authentication/userSignIn',
      userSignInModal: 'modal/userSignInModal',
      userSignUpModal: 'modal/userSignUpModal'
    }),
    signInAction(user) {
      if (this.$refs.form.validate()) {
        this.userSignIn(user)
      }
    },
    dialogClose() {
      this.userSignInModal(false)
      this.$refs.form.reset()
    },
    newDialog() {
      this.userSignInModal(false)
      this.$refs.form.reset()
      this.userSignUpModal(true)
    },
    guestSignIn() {
      this.userSignIn(this.guest)
      this.userSignInModal(false)
    }
  }
}
</script>
