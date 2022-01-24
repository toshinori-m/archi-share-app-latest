<template>
  <v-card>
    <v-card-actions class="pa-0">
      <v-spacer />
      <v-btn
        icon
        large
        @click="closeDialog"
      >
        <v-icon>
          mdi-close
        </v-icon>
      </v-btn>
    </v-card-actions>
    <v-toolbar dense flat color="tertiary" class="mb-4">
      <v-toolbar-title class="primary--text mx-auto">
        投稿編集
      </v-toolbar-title>
    </v-toolbar>
    <v-card-text>
      <v-form ref="form">
        <v-autocomplete
          v-model="architecture"
          :items="architectures"
          item-text="name"
          item-value="id"
          no-data-text="該当する建築物はありません"
          placeholder="紐付けしたい建築物を選択"
          clearable
          color="secondary"
          prepend-icon="mdi-home"
        />
        <v-file-input
          v-model="sendImage"
          accept="image/png, image/jpeg, image/bmp"
          label="画像を変更する場合は選択"
          color="secondary"
          prepend-icon="mdi-image"
          @change="setImage"
        />
        <v-text-field
          v-model="title"
          label="投稿名"
          :rules="titleRules"
          validate-on-blur
          counter="30"
          color="secondary"
          prepend-icon="mdi-lead-pencil"
        />
        <v-textarea
          v-model="content"
          label="内容"
          :rules="contentRules"
          validate-on-blur
          counter="200"
          color="secondary"
          prepend-icon="mdi-note-text"
        />
      </v-form>
    </v-card-text>
    <v-card-actions class="justify-center pa-5 pt-0">
      <v-btn
        :disabled="imageCheck"
        color="green"
        class="mr-2"
        @click="dialog = true"
      >
        画像プレビュー
      </v-btn>
      <v-dialog v-model="dialog" persistent width="500">
        <post-image-preview :image="image" @close="dialog = false" />
      </v-dialog>
      <v-btn
        width="125"
        color="secondary"
        @click="postEditAction"
      >
        編集を完了
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import PostImagePreview from '~/components/post/PostImagePreview.vue'
export default {
  components: {
    PostImagePreview
  },
  data() {
    return {
      title: '',
      content: '',
      image: null,
      sendImage: null,
      architecture: null,
      architectures: [],
      titleRules: [
        v => !!v || '投稿名を入力してください',
        v => (v && v.length <= 30) || '30文字以内で入力してください'
      ],
      contentRules: [
        v => !!v || '内容を入力してください',
        v => (v && v.length <= 200) || '200文字以内で入力してください'
      ],
      dialog: false
    }
  },
  computed: {
    ...mapGetters({
      post: 'post/post',
      currentUser: 'authentication/currentUser'
    }),
    imageCheck() {
      if (this.sendImage) {
        return false
      } else {
        return true
      }
    }
  },
  mounted() {
    this.title = this.post.title
    this.content = this.post.content
    if (this.post.architecture) {
      this.architecture = this.post.architecture.id
    }
    this.$axios
      .get('/api/v1/architectures')
      .then((res) => {
        this.architectures = res.data
      })
      .catch((e) => {
        console.log(e)
      })
  },
  methods: {
    ...mapActions({
      postGet: 'post/postGet',
      messageShow: 'snackbarMessage/messageShow'
    }),
    closeDialog() {
      this.$emit('close')
    },
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
      formData.append('title', this.title)
      formData.append('content', this.content)
      if (this.sendImage) {
        formData.append('image', this.sendImage)
      }
      if (this.architecture !== null) {
        if (this.post.architecture && this.post.architecture.id === this.architecture) {
          return formData
        } else {
          formData.append('architecture_id', this.architecture)
        }
      } else {
        formData.append('architecture_id', '')
      }
      return formData
    },
    async postEdit() {
      const formData = this.formCreate()
      const response = await this.$axios
        .patch(`/api/v1/posts/${this.post.id}`, formData, {
          headers: {
            'content-type': 'multipart/form-data'
          }
        })
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async userPostEdit() {
      const res = await this.postEdit()
      if (!res) {
        return
      }
      this.postGet(res.data.id)
      this.closeDialog()
      this.messageShow({
        message: '投稿を編集しました',
        type: 'success',
        status: true
      })
    },
    postEditAction() {
      if (this.$refs.form.validate()) {
        this.userPostEdit()
      }
    }
  }
}
</script>
