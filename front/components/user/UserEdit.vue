<template>
  <v-card>
    <v-card-title class="justify-center">
      <span class="text-h5 text-weight-bold">ユーザー情報編集</span>
    </v-card-title>
    <v-card-text>
      <v-form ref="form">
        <v-row justify="center">
          <v-avatar size="100" class="mb-4">
            <template v-if="image.url !== null">
              <v-img v-if="inputImage !== null" :src="inputImage" />
              <v-img v-else :src="image.url" />
            </template>
            <template v-else>
              <v-img v-if="inputImage" :src="inputImage" />
              <v-img v-else :src="icon" />
            </template>
          </v-avatar>
        </v-row>
        <v-file-input
          v-model="editImage"
          accept="image/png, image/jpeg, image/bmp"
          prepend-icon="mdi-account-box"
          label="ユーザー画像を選択してください"
          @change="setImage"
        />
        <v-text-field
          v-model="name"
          label="ニックネーム"
          :rules="nameRules"
          validate-on-blur
          counter="30"
          prepend-icon="mdi-lead-pencil"
        />
        <v-text-field
          v-model="email"
          label="メールアドレス"
          :rules="emailRules"
          validate-on-blur
          prepend-icon="mdi-email"
        />
        <v-textarea
          v-model="introduction"
          label="プロフィール"
          :rules="introductionRules"
          validate-on-blur
          counter="150"
          prepend-icon="mdi-card-account-details"
        />
      </v-form>
    </v-card-text>
    <v-card-actions class="pa-4">
      <v-btn
        block
        color="light-blue lighten-2"
        @click="userEditAction"
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
      image: null,
      inputImage: null,
      editImage: null,
      icon: require('@/assets/images/default.png'),
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
  created() {
    this.image = this.currentUser.image
    this.name = this.currentUser.name
    this.email = this.currentUser.email
    this.introduction = this.currentUser.introduction
    console.log(this.currentUser)
  },
  methods: {
    ...mapActions({
      currentUserInfo: 'authentication/currentUserInfo',
      messageShow: 'snackbarMessage/messageShow'
    }),
    setImage(file) {
      this.editImage = file
      if (file !== undefined && file !== null) {
        if (file.name.lastIndexOf('.') <= 0) {
          return
        }
        const fr = new FileReader()
        fr.readAsDataURL(file)
        fr.addEventListener('load', () => {
          this.inputImage = fr.result
        })
      } else {
        this.inputImage = null
      }
    },
    async editForm() {
      const formData = new FormData()
      if (this.inputImage !== null) {
        formData.append('image', this.editImage)
      }
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
          this.messageShow({
            message: 'このメールアドレスは既に使用されています',
            type: 'error',
            status: true
          })
        })
      return response
    },
    async userEdit() {
      const res = await this.editForm()
      if (!res) {
        return
      }
      this.currentUserInfo(res.data.data)
      this.editImage = null
      this.messageShow({
        message: 'アカウントを更新しました',
        type: 'success',
        status: true
      })
    },
    userEditAction() {
      if (this.$refs.form.validate()) {
        this.userEdit()
      }
    }
  }
}
</script>
