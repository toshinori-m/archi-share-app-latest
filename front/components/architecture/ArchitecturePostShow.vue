<template>
  <div>
    <v-card-title class="justify-center pb-0">
      <span class="headline">建築物の詳細</span>
    </v-card-title>
    <v-card-actions class="justify-center pa-0">
      <v-btn
        v-if="!list"
        icon
        large
        @click="list = true"
      >
        <v-icon>
          mdi-chevron-down
        </v-icon>
      </v-btn>
    </v-card-actions>
    <template v-if="list">
      <div>
        <v-row
          dense
          justify="center"
          align="center"
        >
          <v-col cols="5">
            <div class="pa-2">
              <v-img :src="architecture.image.url" />
            </div>
          </v-col>
          <v-col cols="7">
            <v-list dense>
              <v-list-item>
                <v-list-item-content>
                  建築名：
                </v-list-item-content>
                <v-list-item-content class="align-end">
                  {{ architecture.name }}
                </v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>
                  住所：
                </v-list-item-content>
                <v-list-item-content class="align-end">
                  {{ architecture.prefecture + architecture.address }}
                </v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>
                  構造：
                </v-list-item-content>
                <v-list-item-content class="align-end">
                  {{ architecture.construction }}
                </v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>
                  設計者：
                </v-list-item-content>
                <v-list-item-content class="align-end">
                  {{ architecture.designer }}
                </v-list-item-content>
              </v-list-item>
              <v-list-item>
                <v-list-item-content>
                  階数：
                </v-list-item-content>
                <v-list-item-content class="align-end">
                  {{ architecture.above_floor + architecture.under_floor }}
                </v-list-item-content>
              </v-list-item>
            </v-list>
          </v-col>
        </v-row>
      </div>
      <architecture-post-map :architecture="architecture" />
    </template>
    <v-card-actions class="justify-center pa-0">
      <v-btn
        v-if="list"
        icon
        large
        @click="list = false"
      >
        <v-icon>
          mdi-chevron-up
        </v-icon>
      </v-btn>
    </v-card-actions>
  </div>
</template>

<script>
export default {
  props: {
    architecture: {
      type: Object,
      default: () => ({})
    }
  },
  data() {
    return {
      list: false
    }
  }
}
</script>
