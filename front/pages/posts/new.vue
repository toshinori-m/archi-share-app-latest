<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="10" md="8">
      <v-card>
        <v-card-title class="justify-center">
          <span class="headline">新規投稿</span>
        </v-card-title>
        <v-card-text>
          <v-form ref="form">
            <v-row>
              <v-col cols="5">
                <v-avatar tile size="300">
                  <v-img v-if="image" :src="image" />
                  <v-img v-else :src="icon" />
                </v-avatar>
              </v-col>
              <v-col cols="7">
                <v-file-input
                  v-model="sendImage"
                  accept="image/png, image/jpeg, image/bmp"
                  label="投稿する画像を選択してください"
                  :rules="imageRules"
                  validate-on-blur
                  prepend-icon="mdi-image"
                  @change="setImage"
                />
                <v-text-field
                  v-model="title"
                  label="投稿名"
                  :rules="titleRules"
                  validate-on-blur
                  counter="30"
                  prepend-icon="mdi-lead-pencil"
                />
                <v-textarea
                  v-model="content"
                  label="内容"
                  :rules="contentRules"
                  validate-on-blur
                  counter="200"
                  prepend-icon="mdi-note-text"
                />
              </v-col>
            </v-row>
          </v-form>
        </v-card-text>
        <v-card-actions class="pa-4 pt-0">
          <v-btn
            block
            color="light-blue lighten-2"
            @click="postCreateAction"
          >
            投稿
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  data() {
    return {
      title: '',
      content: '',
      image: null,
      sendImage: null,
      icon: require('@/assets/images/sample.jpg'),
      imageRules: [
        v => !!v || '画像を選択してください'
      ],
      titleRules: [
        v => !!v || '投稿名を入力してください',
        v => (v && v.length <= 30) || '30文字以内で入力してください'
      ],
      contentRules: [
        v => !!v || '内容を入力してください',
        v => (v && v.length <= 200) || '200文字以内で入力してください'
      ]
    }
  },
  head() {
    return {
      title: '新規投稿'
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
    setImage(file) {
      this.sendImage = file
      if (file !== undefined && file !== null) {
        if (file.name.lastIndexOf('.') <= 0) {
          return
        }
        const fr = new FileReader()
        fr.readAsDataURL(file)
        fr.addEventListener('load', () => {
          this.image = fr.result
        })
      } else {
        this.image = null
      }
    },
    formCreate() {
      const formData = new FormData()
      formData.append('user_id', this.currentUser.id)
      formData.append('title', this.title)
      formData.append('content', this.content)
      formData.append('image', this.sendImage)
      return formData
    },
    async postCreate() {
      const formData = this.formCreate()
      const response = await this.$axios
        .post('/api/v1/posts', formData, {
          headers: {
            'content-type': 'multipart/form-data'
          }
        })
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async userPostCreate() {
      const res = await this.postCreate()
      if (!res) {
        return
      }
      this.$router.push('/')
      this.messageShow({
        message: '投稿しました',
        type: 'success',
        status: true
      })
    },
    postCreateAction() {
      if (this.$refs.form.validate()) {
        this.userPostCreate()
      }
    }
  }
}
</script>
