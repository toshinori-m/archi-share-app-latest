<template>
  <v-card>
    <v-card-actions class="pb-0">
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
    <v-card-title class="justify-center">
      <span class="headline">建築物登録</span>
    </v-card-title>
    <v-window v-model="step">
      <v-window-item :value="1">
        <v-card-text>
          <v-form ref="archi_form">
            <v-text-field
              v-model="name"
              label="建築名"
              :rules="nameRules"
              :error-messages="error"
              validate-on-blur
              counter="30"
              prepend-icon="mdi-pencil"
              @change="error = []"
            />
            <v-select
              v-model="prefecture"
              label="都道府県"
              :items="prefectures"
              :rules="prefectureRules"
              clearable
              validate-on-blur
              prepend-icon="mdi-map-marker"
            />
            <v-text-field
              v-model="address"
              label="住所（都道府県以下を入力）"
              :rules="addressRules"
              validate-on-blur
              counter="50"
              prepend-icon="mdi-map-marker"
            />
          </v-form>
        </v-card-text>
      </v-window-item>
      <v-window-item :value="2">
        <v-card-text>
          <v-form ref="show_form">
            <v-select
              v-model="construction"
              multiple
              label="構造"
              :items="construct"
              :rules="constructionRules"
              validate-on-blur
              clearable
              prepend-icon="mdi-home"
            />
            <v-text-field
              v-model="designer"
              label="設計者"
              :rules="designerRules"
              validate-on-blur
              counter="20"
              prepend-icon="mdi-account-edit"
            />
            <v-select
              v-model="aboveFloor"
              :items="above"
              label="地上階"
              :rules="aboveRules"
              validate-on-blur
              clearable
              prepend-icon="mdi-stairs-up"
            />
            <v-select
              v-model="underFloor"
              :items="under"
              placeholder="地下がある場合は選択してください"
              clearable
              prepend-icon="mdi-stairs-down"
            />
          </v-form>
        </v-card-text>
      </v-window-item>
      <v-window-item :value="3">
        <v-card-text>
          <v-form ref="image_form">
            <v-img
              v-if="image"
              :src="image"
              max-width="400px"
              max-height="300px"
              class="mx-auto"
            />
            <v-img
              v-else
              :src="icon"
              max-width="400px"
              max-height="200px"
              class="mx-auto"
            />
            <v-file-input
              v-model="sendImage"
              accept="image/png, image/jpeg, image/bmp"
              label="登録する建築物の画像を選択してください"
              :rules="imageRules"
              validate-on-blur
              prepend-icon="mdi-image"
              @change="setImage"
            />
          </v-form>
        </v-card-text>
      </v-window-item>
    </v-window>
    <v-card-actions class="justify-end align-end pa-6 pt-0 mt-auto mb-0">
      <v-btn
        :disabled="step === 1"
        @click="step--"
      >
        戻る
      </v-btn>
      <v-spacer />
      <v-btn
        v-if="step === 1"
        color="light-blue lighten-2"
        @click="archiValidation"
      >
        次へ
      </v-btn>
      <v-btn
        v-if="step === 2"
        color="light-blue lighten-2"
        @click="showValidation"
      >
        次へ
      </v-btn>
      <v-btn
        v-if="step === 3"
        color="light-blue lighten-2"
        @click="archiCreateAction"
      >
        登録
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
import { mapMutations, mapActions } from 'vuex'
export default {
  data() {
    return {
      dialog: false,
      step: 0,
      name: '',
      prefecture: null,
      designer: '',
      address: '',
      construction: null,
      aboveFloor: null,
      underFloor: null,
      image: null,
      sendImage: null,
      error: [],
      icon: require('@/assets/images/sample.jpg'),
      prefectures: [
        '北海道','青森', '岩手', '宮城', '秋田', '山形','福島', '茨城',
        '栃木', '群馬', '埼玉', '千葉', '東京', '神奈川','新潟', '富山',
        '石川', '福井', '山梨', '長野', '岐阜', '静岡','愛知', '三重',
        '滋賀', '京都', '大阪', '兵庫', '奈良', '和歌山','鳥取', '島根',
        '岡山', '広島', '山口', '徳島', '香川', '愛媛','高知', '福岡',
        '佐賀', '長崎', '熊本', '大分', '宮崎', '鹿児島','沖縄'
      ],
      construct: [
        '木造',
        '鉄骨造',
        '鉄筋コンクリート造',
        '鉄骨鉄筋コンクリート造',
        'RS造'
      ],
      above: Array.from(new Array(10)).map((v, i) => i + 1 + '階'),
      under: Array.from(new Array(5)).map((v, i) => '地下' + (i + 1) + '階'),
      imageRules: [
        v => !!v || '画像を選択してください'
      ],
      nameRules: [
        v => !!v || '建築名を入力してください',
        v => (v && v.length <= 30) || '30文字以内で入力してください'
      ],
      prefectureRules: [
        v => !!v || '都道府県を選択してください'
      ],
      addressRules: [
        v => !!v || '住所を入力してください',
        v => (v && v.length <= 50) || '50文字以内で入力してください'
      ],
      constructionRules: [
        v => !!v || '構造を選択してください'
      ],
      designerRules: [
        v => !!v || '設計者を入力してください',
        v => (v && v.length <= 20) || '20文字以内で入力してください'
      ],
      aboveRules: [
        v => !!v || '階数（地上）を選択してください'
      ]
    }
  },
  methods: {
    ...mapMutations('architecture', [
      'archiSet'
    ]),
    ...mapActions('snackbarMessage', [
      'messageShow'
    ]),
    closeDialog() {
      this.$emit('close')
    },
    archiValidation() {
      if (this.$refs.archi_form.validate() && !this.error[0]) {
        this.step++
      }
    },
    showValidation() {
      if (this.$refs.show_form.validate()) {
        this.step++
      }
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
      formData.append('name', this.name)
      formData.append('prefecture', this.prefecture)
      formData.append('address', this.address)
      formData.append('construction', this.construction)
      formData.append('designer', this.designer)
      formData.append('image', this.sendImage)
      return formData
    },
    async archiCreate() {
      const formData = this.formCreate()
      const response = await this.$axios
        .post('/api/v1/architectures', formData, {
          headers: {
            'content-type': 'multipart/form-data'
          }
        })
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    errorValidation(message) {
      if (message.name[0] === 'has already been taken') {
        this.error = ['この建築名は既に登録されています']
        this.step = 1
      }
    },
    async userArchiCreate() {
      const res = await this.archiCreate()
      if (!res) {
        return
      }
      console.log(res)
      if (res.data.message) {
        this.errorValidation(res.data.message)
        return
      }
      this.archiSet(res.data)
      this.$emit('close')
      this.messageShow({
        message: '建築物を登録しました',
        type: 'success',
        status: true
      })
    },
    archiCreateAction() {
      if (this.$refs.image_form.validate()) {
        this.userArchiCreate()
      }
    }
  }
}
</script>
