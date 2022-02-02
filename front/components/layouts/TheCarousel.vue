<template>
  <v-carousel
    cycle
    hide-delimiters
    :height="carouselHeight"
  >
    <v-carousel-item
      v-for="slide in items"
      :key="slide.id"
    >
      <v-sheet height="100%">
        <v-row
          justify="center"
          align="end"
          class="fill-height"
        >
          <v-col cols="12">
            <v-img
              :src="slide.image.url"
              :max-height="heightValue"
              contain
            />
            <p
              class="text-h6
              text-truncate
              mb-0
              text-center"
            >
              {{ slide.title }}
            </p>
            <p class="text-h6 text-center">
              いいね数
              <span class="font-weight-bold">
                {{ slide.like_users.length }}
              </span>
            </p>
          </v-col>
        </v-row>
      </v-sheet>
    </v-carousel-item>
  </v-carousel>
</template>

<script>
export default {
  props: {
    items: {
      type: Array,
      required: true
    }
  },
  computed: {
    heightValue() {
      if (this.$vuetify.breakpoint.xsOnly) {
        return 200
      } else {
        return 400
      }
    },
    carouselHeight() {
      if (this.$vuetify.breakpoint.xsOnly) {
        return 270
      } else {
        return 470
      }
    }
  }
}
</script>
