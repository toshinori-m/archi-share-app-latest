<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="10" md="10">
      <v-alert
        border="top"
        colored-border
        type="info"
        elevation="2"
      >
        <span class="primary--text">
          紐付けしたい建築物が無い場合は、
          <v-btn
            text
            color="blue"
            width="65"
            @click="dialog = true"
          >
            こちら
          </v-btn>
          で建築物の登録が出来ます
        </span>
      </v-alert>
      <template v-if="dialog">
        <v-dialog
          v-if="$vuetify.breakpoint.xsOnly"
          v-model="dialog"
          fullscreen
          hide-overlay
        >
          <architecture-create-modal @close="closeDialog" />
        </v-dialog>
        <v-dialog
          v-else
          v-model="dialog"
          persistent
          width="600"
        >
          <architecture-create-modal @close="closeDialog" />
        </v-dialog>
      </template>
      <v-card>
        <v-toolbar flat color="tertiary">
          <v-toolbar-title class="mx-auto">
            <span class="headline primary--text">
              投稿フォーム
            </span>
          </v-toolbar-title>
        </v-toolbar>
        <v-card-text>
          <v-form ref="form">
            <v-row justify="center" align="center">
              <v-col cols="12" sm="10" md="6">
                <div class="pb-0">
                  <v-img
                    v-if="image"
                    :src="image"
                    class="mx-auto"
                  />
                  <v-img
                    v-else
                    :src="icon"
                    class="mx-auto"
                  />
                </div>
              </v-col>
              <v-col cols="12" sm="10" md="6">
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
                  label="投稿する画像を選択"
                  :rules="imageRules"
                  validate-on-blur
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
                <v-card-actions class="pa-0 pt-4">
                  <v-btn
                    block
                    color="tertiary"
                    class="primary--text"
                    @click="postCreateAction"
                  >
                    投稿
                  </v-btn>
                </v-card-actions>
              </v-col>
            </v-row>
          </v-form>
        </v-card-text>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import ArchitectureCreateModal from '~/components/architecture/ArchitectureCreateModal.vue'
export default {
  components: {
    ArchitectureCreateModal
  },
  async asyncData({ $axios }) {
    const architectures = await $axios
      .$get('/api/v1/architectures')
    return { architectures }
  },
  data() {
    return {
      title: '',
      content: '',
      image: null,
      sendImage: null,
      architecture: null,
      architectures: [],
      dialog: false,
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
    ...mapGetters({
      currentUser: 'authentication/currentUser',
      archi: 'architecture/architecture'
    }),
    loadArchi() {
      return this.archi
    }
  },
  watch: {
    loadArchi() {
      this.architectures.unshift(this.archi)
    }
  },
  methods: {
    ...mapActions({
      architecturesGet: 'architecture/architecturesGet',
      messageShow: 'snackbarMessage/messageShow'
    }),
    closeDialog() {
      this.dialog = false
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
      formData.append('user_id', this.currentUser.id)
      formData.append('title', this.title)
      formData.append('content', this.content)
      formData.append('image', this.sendImage)
      if (this.architecture) {
        formData.append('architecture_id', this.architecture)
      }
      console.log(this.architecture)
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
