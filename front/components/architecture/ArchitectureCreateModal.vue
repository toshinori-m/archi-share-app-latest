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
            <v-combobox
              v-model="aboveFloor"
              :items="above"
              label="地上階"
              :rules="aboveRules"
              validate-on-blur
              clearable
              prepend-icon="mdi-stairs-up"
            />
            <v-combobox
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
        '北海道','青森県', '岩手県', '宮城県', '秋田県', '山形県','福島県', '茨城県',
        '栃木県', '群馬県', '埼玉県', '千葉県', '東京都', '神奈川県','新潟県', '富山県',
        '石川県', '福井県', '山梨県', '長野県', '岐阜県', '静岡県','愛知県', '三重県',
        '滋賀県', '京都府', '大阪府', '兵庫県', '奈良県', '和歌山県','鳥取県', '島根県',
        '岡山県', '広島県', '山口県', '徳島県', '香川県', '愛媛県','高知県', '福岡県',
        '佐賀県', '長崎県', '熊本県', '大分県', '宮崎県', '鹿児島県','沖縄県'
      ],
      construct: [
        '木造',
        '鉄骨造',
        '鉄筋コンクリート造',
        '鉄骨鉄筋コンクリート造',
        'RS造'
      ],
      above: Array.from(new Array(10)).map((v, i) => '地上' + (i + 1) + '階'),
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
        v => !!v || '階数を選択または入力してください'
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
      formData.append('above_floor', this.aboveFloor)
      formData.apeend('under_floor', this.underFloor)
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
