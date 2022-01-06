<template>
  <v-row justify="center" align="center">
    <v-col cols="12">
      <div class="mb-5">
        <GmapMap
          :center="{ lat: 35.681236, lng: 139.767125 }"
          :zoom="6"
          :options="options"
          map-type-id="roadmap"
          style="height: 400px"
        >
          <GmapInfoWindow
            v-if="window"
            :options="infoOptions"
            :opened="window"
            :position="windowPosition"
            @closeclick="window = false"
          >
            {{ architecture.name }}
          </GmapInfoWindow>
          <GmapMarker
            v-for="a in architectures"
            :key="a.id"
            :position="{ lat: Number(a.lat), lng: Number(a.lng) }"
            :clickable="true"
            :draggable="false"
            @click="markerClick(a)"
          >
          </GmapMarker>
        </GmapMap>
      </div>
      <v-card v-if="window" class="mb-6">
        <v-toolbar flat color="tertiary" class="mb-2">
          <v-toolbar-title class="primary--text">
            選択した建築物
          </v-toolbar-title>
        </v-toolbar>
        <v-row justify="center" align="center">
          <v-col cols="12" sm="6">
            <v-img :src="architecture.image.url" class="ma-2 mt-0" />
          </v-col>
          <v-col cols="12" sm="6">
            <v-list
              dense
              class="text-caption
              text-sm-subtitle-2
              text-md-subtitle-1"
            >
              <v-list-item>
                <v-list-item-content>
                  建築名:
                </v-list-item-content>
                <v-list-item-content class="align-end">
                  {{ architecture.name }}
                </v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>
                  住所:
                </v-list-item-content>
                <v-list-item-content class="align-end">
                  {{ architecture.prefecture + architecture.address }}
                </v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>
                  構造:
                </v-list-item-content>
                <v-list-item-content class="align-end">
                  {{ architecture.construction }}
                </v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>
                  設計者:
                </v-list-item-content>
                <v-list-item-content class="align-end">
                  {{ architecture.designer }}
                </v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>
                  階数:
                </v-list-item-content>
                <v-list-item-content class="align-end">
                  {{ architecture.above_floor + architecture.under_floor }}
                </v-list-item-content>
              </v-list-item>
            </v-list>
          </v-col>
        </v-row>
      </v-card>
      <post-index
        v-if="window"
        :posts="architecture.posts"
        :tool-title="toolTitle"
        @load="loadArchi(architecture)"
      />
      <v-alert
        v-if="!window"
        border="top"
        colored-border
        type="info"
        elevation="2"
      >
        <span>マップ上のマーカーを選択することで建築物の情報を表示</span>
      </v-alert>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import PostIndex from '~/components/post/PostIndex.vue'
export default {
  components: {
    PostIndex
  },
  async asyncData({ $axios }) {
    const architectures = await $axios
      .$get('/api/v1/architectures')
    return { architectures }
  },
  data() {
    return {
      lat: '',
      lng: '',
      options: {
        mapTypeControl: false,
        streetViewControl: false
      },
      architectures: null,
      window: false,
      windowPosition: null,
      infoOptions: {
        pixelOffset: {
          width: 0,
          height: -35
        }
      },
      itemsPerPageArray: [6, 9, 12],
      page: 1,
      itemsPerPage: 6,
      toolTitle: '関連する投稿'
    }
  },
  head() {
    return {
      title: '建築物を探す'
    }
  },
  computed: {
    ...mapGetters('architecture', [
      'architecture'
    ])
  },
  methods: {
    ...mapActions('architecture', [
      'archiGet'
    ]),
    async markerClick(architecture) {
      await this.archiGet(architecture)
      this.windowPosition = { lat: Number(architecture.lat), lng: Number(architecture.lng) }
      this.window = true
    },
    async loadArchi(architecture) {
      await this.archiGet(architecture)
    }
  }
}
</script>

