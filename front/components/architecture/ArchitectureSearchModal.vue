<template>
  <div>
    <v-btn
      color="secondary"
      class="ml-2"
      @click="dialog = true"
    >
      <v-icon>
        mdi-clipboard-text-search-outline
      </v-icon>
      <span v-if="$vuetify.breakpoint.smAndUp">
        絞り込み検索
      </span>
    </v-btn>
    <v-dialog
      v-model="dialog"
      :fullscreen="windowSize"
      :hide-overlay="windowSize"
      :persistent="!windowSize"
      width="600"
    >
      <v-card>
        <v-card-actions class="justify-end pa-0">
          <v-btn icon large @click="dialog = false">
            <v-icon>
              mdi-close
            </v-icon>
          </v-btn>
        </v-card-actions>
        <v-toolbar flat dense color="tertiary">
          <v-toolbar-title class="primary--text mx-auto">
            {{ title }}
          </v-toolbar-title>
        </v-toolbar>
        <v-window v-model="step">
          <v-window-item :value="1">
            <v-card-text>
              <v-row dense>
                <v-col cols="12" sm="6">
                  <v-select
                    v-model="filterQuery.prefecture"
                    label="都道府県"
                    :items="prefectures"
                    hide-details
                    clearable
                    color="secondary"
                    validate-on-blur
                    prepend-icon="mdi-map-marker"
                  />
                </v-col>
                <v-col cols="12" sm="6">
                  <v-text-field
                    v-model="filterQuery.designer"
                    label="設計者"
                    hide-details
                    color="secondary"
                    prepend-icon="mdi-account-edit"
                  />
                </v-col>
              </v-row>
              <v-row dense>
                <v-col cols="12">
                  <v-combobox
                    v-model="filterQuery.construction"
                    :items="construct"
                    label="構造"
                    multiple
                    hide-details
                    clearable
                    color="secondary"
                    prepend-icon="mdi-home"
                  />
                </v-col>
              </v-row>
              <v-row dense>
                <v-col cols="12" sm="6">
                  <v-combobox
                    v-model="filterQuery.aboveFloor"
                    :items="above"
                    label="地上階"
                    hide-details
                    clearable
                    color="secondary"
                    prepend-icon="mdi-stairs-up"
                  />
                </v-col>
                <v-col cols="12" sm="6">
                  <v-combobox
                    v-model="filterQuery.underFloor"
                    :items="under"
                    label="地下階"
                    hide-details
                    clearable
                    color="secondary"
                    prepend-icon="mdi-stairs-down"
                  />
                </v-col>
              </v-row>
            </v-card-text>
            <v-card-actions class="pa-4 pt-0">
              <v-btn
                block
                color="tertiary"
                class="primary--text"
                @click="searchButton"
              >
                検索
              </v-btn>
            </v-card-actions>
          </v-window-item>
          <v-window-item :value="2">
            <v-list v-if="filteredArchitectures[0]">
              <v-list-item
                v-for="architecture in filteredArchitectures"
                :key="architecture.id"
                @click="architectureClick(architecture)"
              >
                <v-list-item-avatar tile>
                  <v-img :src="architecture.image.url" />
                </v-list-item-avatar>
                <v-list-item-content>
                  <v-list-item-title class="text-truncate">
                    {{ architecture.name }}
                  </v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list>
            <v-card-text
              v-if="!filteredArchitectures[0]"
              class="text-center"
            >
              <span class="text-subtitle-1">
                該当する建築物はありません
              </span>
            </v-card-text>
            <v-card-actions class="justify-center pa-4 pt-0">
              <v-btn
                block
                color="tertiary"
                class="primary--text"
                @click="step--"
              >
                <v-icon>
                  mdi-chevron-left
                </v-icon>
                検索に戻る
              </v-btn>
            </v-card-actions>
          </v-window-item>
        </v-window>
      </v-card>
    </v-dialog>
  </div>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex'
export default {
  data() {
    return {
      dialog: false,
      step: 1,
      title: '絞り込み検索',
      filterQuery: {
        prefecture: null,
        designer: '',
        construction: [],
        aboveFloor: null,
        underFloor: null
      },
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
    }
  },
  computed: {
    ...mapGetters('architecture', [
      'filteredArchitectures'
    ]),
    stepCheck() {
      return this.step
    },
    windowSize() {
      if (this.$vuetify.breakpoint.xsOnly) {
        return true
      } else {
        return false
      }
    }
  },
  watch: {
    stepCheck() {
      if (this.step === 1) {
        this.title = '絞り込み検索'
      } else {
        this.title = '検索結果'
      }
    }
  },
  methods: {
    ...mapMutations('architecture', [
      'filterQuerySet'
    ]),
    ...mapActions('architecture', [
      'archiGet'
    ]),
    searchButton() {
      this.filterQuerySet(this.filterQuery)
      this.step++
    },
    architectureClick(architecture) {
      this.archiGet(architecture)
      this.dialog = false
    }
  }
}
</script>
