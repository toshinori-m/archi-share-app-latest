<template>
  <v-carousel
    cycle
    height="400"
    hide-delimiter-background
    show-arrows-on-hover
  >
    <v-carousel-item
      v-for="slide in items"
      :key="slide.id"
    >
      <v-card>
        <v-row
          class="fill-height"
          align="center"
          justify="center"
        >
          <v-col cols="6">
            <div>
              <v-img :src="slide.image.url" height="400" />
            </div>
          </v-col>
          <v-col cols="6">
            <div>
              {{ slide.title }}
            </div>
          </v-col>
        </v-row>
      </v-card>
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
  }
}
</script>
