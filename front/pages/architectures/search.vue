<template>
  <v-row justify="center" align="center">
    <v-col cols="12">
      <v-toolbar dark flat color="accent">
        <v-combobox
          ref="reset_form"
          v-model="selectedItem"
          :items="architectures"
          item-text="name"
          no-data-text="建築物がまだ登録されていません"
          flat
          solo-inverted
          hide-details
          clearable
          prepend-inner-icon="mdi-magnify"
        />
        <v-spacer /> 
        <architecture-search-modal />
      </v-toolbar>
      <div class="mb-5">
        <GmapMap
          ref="map"
          :center="center"
          :zoom="zoom"
          :options="options"
          map-type-id="roadmap"
          style="height: 400px"
        >
          <GmapInfoWindow
            v-if="window"
            :options="infoOptions"
            :opened="window"
            :position="windowPosition"
            @closeclick="windowClose"
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
          <v-spacer />
          <architecture-delete-modal v-if="currentUser && currentUser.admin" />
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
                  <template v-if="architecture.under_floor">
                    {{ architecture.above_floor + architecture.under_floor }}
                  </template>
                  <template v-else>
                    {{ architecture.above_floor }}
                  </template>
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
        <span>
          マップ上のマーカーを選択、
          またはフォームで該当する建築物を選択することで
          建築物の情報を表示
        </span>
      </v-alert>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex'
import PostIndex from '~/components/post/PostIndex.vue'
import ArchitectureSearchModal from '~/components/architecture/ArchitectureSearchModal.vue'
import ArchitectureDeleteModal from '~/components/architecture/ArchitectureDeleteModal.vue'
export default {
  components: {
    PostIndex,
    ArchitectureSearchModal,
    ArchitectureDeleteModal
  },
  data() {
    return {
      selectedItem: null,
      lat: '',
      lng: '',
      zoom: 5.8,
      options: {
        mapTypeControl: false,
        streetViewControl: false
      },
      center: {
        lat: 35.681236,
        lng: 139.767125
      },
      window: false,
      windowPosition: null,
      infoOptions: {
        pixelOffset: {
          width: 0,
          height: -35
        }
      },
      toolTitle: '関連する投稿'
    }
  },
  async fetch ({ $axios, store }) {
    await $axios
      .$get('/api/v1/architectures')
      .then((res) => {
        store.commit('architecture/architecturesSet', res)
      })
      .catch((e) => {
        console.log(e)
      })
  },
  head() {
    return {
      title: '建築物を探す'
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser',
      architecture: 'architecture/architecture',
      architectures: 'architecture/architectures'
    }),
    architectureCheck() {
      return this.architecture
    },
    selectedItemCheck() {
      return this.selectedItem
    }
  },
  watch: {
    architectureCheck() {
      if (this.architecture) {
        this.windowPosition = {
          lat: Number(this.architecture.lat), lng: Number(this.architecture.lng)
        }
        this.$refs.map.panTo(
          { lat: Number(this.architecture.lat), lng:  Number(this.architecture.lng) }
        )
        this.window = true
      } else {
        this.window = false
        this.$refs.reset_form.reset()
      }
    },
    selectedItemCheck() {
      if (this.selectedItem) {
        this.archiGet(this.selectedItem)
      } else {
        this.archiSet(null)
      }
    }
  },
  methods: {
    ...mapMutations('architecture', [
      'archiSet',
      'architecturesSet'
    ]),
    ...mapActions('architecture', [
      'archiGet'
    ]),
    async markerClick(architecture) {
      await this.archiGet(architecture)
      this.windowPosition = { lat: Number(architecture.lat), lng: Number(architecture.lng) }
      this.$refs.map.panTo({ lat: Number(architecture.lat), lng:  Number(architecture.lng) })
      this.window = true
    },
    async loadArchi(architecture) {
      await this.archiGet(architecture)
    },
    windowClose() {
      this.window = false
      this.archiSet(null)
    }
  }
}
</script>

