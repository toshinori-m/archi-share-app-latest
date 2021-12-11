<template>
  <v-row justify="center" align="center" dense>
    <v-col cols="12" sm="10" md="8">
      <v-card>
        <v-card-title class="justify-center">
          <span class="headline">新規投稿</span>
        </v-card-title>
        <v-card-text>
          <v-form ref="form">
            <v-row justify="center" align="end">
              <v-col cols="6">
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
                <v-file-input
                  v-model="sendImage"
                  accept="image/png, image/jpeg, image/bmp"
                  label="投稿する画像を選択してください"
                  :rules="imageRules"
                  validate-on-blur
                  class="file"
                  prepend-icon="mdi-image"
                  @change="setImage"
                />
              </v-col>
              <v-col cols="6">
                <v-card-actions class="justify-center pa-0">
                  <span>
                    ※紐付けしたい建築物が無い場合は
                  </span>
                  <v-btn
                    text
                    color="blue"
                    @click="dialog = true"
                  >
                    こちら
                  </v-btn>
                </v-card-actions>
                <v-autocomplete
                  v-model="architecture"
                  :items="architectures"
                  item-text="name"
                  item-value="id"
                  placeholder="紐付けしたい建築物を選択してください"
                  clearable
                  prepend-icon="mdi-home"
                />
                <template v-if="dialog">
                  <v-dialog v-model="dialog" persistent width="500px">
                    <architecture-create-modal @close="closeDialog" />
                  </v-dialog>
                </template>
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
                <v-card-actions class="px-0 pb-6">
                  <v-btn
                    block
                    color="light-blue lighten-2"
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
      formData.append('architecture_id', this.architecture)
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

<style scoped>
.file {
  margin-bottom: 2px;
}
</style>
