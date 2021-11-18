<template>
  <v-card>
    <v-card-title class="justify-center">
      <span class="text-h5 text-weight-bold">アカウント編集</span>
    </v-card-title>
    <v-card-text>
      <v-form>
        <v-text-field
          v-model="name"
          label="ニックネーム"
          :rules="nameRules"
          counter="30"
          prepend-icon="mdi-lead-pencil"
        />
        <v-text-field
          v-model="email"
          label="メールアドレス"
          :rules="emailRules"
          prepend-icon="mdi-email"
        />
        <v-textarea
          v-model="introduction"
          label="プロフィール"
          :rules="introductionRules"
          counter="150"
          prepend-icon="mdi-card-account-details"
        />
      </v-form>
    </v-card-text>
    <v-card-actions class="pa-4">
      <v-btn
        block
        color="light-blue lighten-2"
        @click="userEdit"
      >
        更新
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  data() {
    return {
      name: '',
      email: '',
      introduction: '',
      nameRules: [
        v => !!v || '名前を入力してください',
        v => (v && v.length <= 30) || '30文字以内で入力してください'
      ],
      emailRules: [
        v => !!v || 'メールアドレスを入力してください',
        v => /.+@.+\..+/.test(v) || '正しいメールアドレスを入力してください'
      ],
      introductionRules: [
        v => (v && v.length <= 150) || '150文字以内で入力してください'
      ]
    }
  },
  computed: {
    ...mapGetters('authentication', [
      'currentUser'
    ])
  },
  mounted() {
    this.name = this.currentUser.name
    this.email = this.currentUser.email
    this.introduction = this.currentUser.introduction
  },
  methods: {
    ...mapActions({
      currentUserInfo: 'authentication/currentUserInfo',
      messageShow: 'snackbarMessage/messageShow'
    }),
    async editForm() {
      const formData = new FormData()
      formData.append('name', this.name)
      formData.append('email', this.email)
      formData.append('introduction', this.introduction)
      const response = await this.$axios
        .put('/api/v1/auth', formData, {
          headers: {
            'Content-Type': 'multipart/form-data'
          }
        })
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async userEdit() {
      const res = await this.editForm()
      if (!res) {
        return
      }
      this.currentUserInfo(res.data.data)
      this.messageShow({
        message: 'アカウントを更新しました',
        type: 'success',
        status: true
      })
    }
  }
}
</script>
