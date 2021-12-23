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
    <v-toolbar dense flat color="tertiary">
      <v-toolbar-title class="primary--text mx-auto">
        建築物登録
      </v-toolbar-title>
    </v-toolbar>
    <v-stepper
      v-model="e1"
      flat
    >
      <v-stepper-header class="primary--text mx-6">
        <v-stepper-step
          :complete="e1 > 1"
          step="1"
          :rules="step1Error"
          error-icon="mdi-alert-circle-outline"
          color="tertiary"
        >
          基本情報入力
        </v-stepper-step>
        <v-divider />
        <v-stepper-step
          :complete="e1 > 2"
          step="2"
          :rules="step2Error"
          error-icon="mdi-alert-circle-outline"
          color="tertiary"
        >
          詳細情報入力
        </v-stepper-step>
        <v-divider />
        <v-stepper-step
          step="3"
          :rules="step3Error"
          error-icon="mdi-alert-circle-outline"
          color="tertiary"
        >
          画像選択
        </v-stepper-step>
      </v-stepper-header>
      <v-stepper-items>
        <v-stepper-content step="1">
          <v-form ref="step1_form">
            <v-text-field
              v-model="name"
              label="建築名"
              :rules="nameRules"
              :error-messages="error"
              validate-on-blur
              counter="30"
              color="secondary"
              prepend-icon="mdi-pencil"
              @input="error = []"
            />
            <v-select
              v-model="prefecture"
              label="都道府県"
              :items="prefectures"
              :rules="prefectureRules"
              clearable
              color="secondary"
              validate-on-blur
              prepend-icon="mdi-map-marker"
            />
            <v-text-field
              v-model="address"
              label="住所（都道府県以下を入力）"
              :rules="addressRules"
              validate-on-blur
              counter="50"
              color="secondary"
              prepend-icon="mdi-map-marker"
            />
          </v-form>
        </v-stepper-content>
        <v-stepper-content step="2">
          <v-form ref="step2_form">
            <v-combobox
              v-model="construction"
              multiple
              label="構造"
              :items="construct"
              :rules="constructionRules"
              validate-on-blur
              clearable
              color="secondary"
              prepend-icon="mdi-home"
            />
            <v-text-field
              v-model="designer"
              label="設計者"
              :rules="designerRules"
              validate-on-blur
              counter="20"
              color="secondary"
              prepend-icon="mdi-account-edit"
            />
            <v-combobox
              v-model="aboveFloor"
              :items="above"
              label="地上階"
              :rules="aboveRules"
              validate-on-blur
              clearable
              color="secondary"
              prepend-icon="mdi-stairs-up"
            />
            <v-combobox
              v-model="underFloor"
              :items="under"
              placeholder="地下がある場合は選択してください"
              clearable
              color="secondary"
              prepend-icon="mdi-stairs-down"
            />
          </v-form>
        </v-stepper-content>
        <v-stepper-content step="3">
          <v-form ref="step3_form">
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
              max-height="300px"
              class="mx-auto"
            />
            <v-file-input
              v-model="sendImage"
              accept="image/png, image/jpeg, image/bmp"
              label="登録する建築物の画像を選択してください"
              :rules="imageRules"
              validate-on-blur
              color="secondary"
              prepend-icon="mdi-image"
              @change="setImage"
            />
          </v-form>
        </v-stepper-content>
      </v-stepper-items>
    </v-stepper>
    <v-card-actions class="justify-end align-end pa-6 pt-0 mt-auto mb-0">
      <v-btn
        v-if="e1 > 1"
        color="grey lighten-2"
        @click="e1--"
      >
        戻る
      </v-btn>
      <v-btn
        v-if="e1 === 2"
        color="light-green"
        @click="skipButtonValidation"
      >
        スキップ
      </v-btn>
      <v-btn
        v-if="e1 === 1"
        color="tertiary"
        class="primary--text"
        @click="step1Validation"
      >
        次へ
      </v-btn>
      <v-btn
        v-if="e1 === 2"
        color="tertiary"
        class="primary--text"
        @click="step2Validation"
      >
        次へ
      </v-btn>
      <v-btn
        v-if="e1 === 3"
        color="tertiary"
        class="primary--text"
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
      e1: 1,
      step1Error: [],
      step2Error: [],
      step3Error: [],
      name: '',
      prefecture: null,
      designer: null,
      address: '',
      construction: [],
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
        v => (!!v && v.length > 0) || '構造を選択または入力してください'
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
    step1Validation() {
      if (this.$refs.step1_form.validate() && !this.error[0]) {
        this.e1++
        this.step1Error = [() => true]
      } else {
        this.step1Error = [() => false]
      }
    },
    step2Validation() {
      if (this.$refs.step2_form.validate()) {
        this.e1++
        this.step2Error = [() => true]
      } else {
        this.step2Error = [() => false]
      }
    },
    skipButtonValidation() {
      this.e1++
      this.step2Error = [() => true]
      this.$refs.step2_form.reset()
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
      formData.append('image', this.sendImage)
      if (this.construction !== []) {
        formData.append('construction', this.construction)
      }
      if (this.designer !== null) {
        formData.append('designer', this.designer)
      }
      if (this.aboveFloor !== null) {
        formData.append('above_floor', this.aboveFloor)
      }
      if (this.underFloor !== null) {
        formData.append('under_floor', this.underFloor)
      }
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
        this.e1 = 1
        this.step1Error = [() => false]
      }
    },
    async userArchiCreate() {
      const res = await this.archiCreate()
      if (!res) {
        return
      }
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
      if (this.$refs.step3_form.validate()) {
        this.userArchiCreate()
      } else {
        this.step3Error = [() => false]
      }
    }
  }
}
</script>
