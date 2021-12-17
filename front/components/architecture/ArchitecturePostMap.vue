<template>
  <div class="px-2">
    <template v-if="loading">
      <GmapMap
        :center="{ lat: lat, lng: lng }"
        :zoom="17"
        :options="options"
        map-type-id="roadmap"
        style="height: 300px"
      >
        <GmapMarker :position="{ lat: lat, lng: lng }" />
      </GmapMap>
    </template>
  </div>
</template>

<script>
import Vue from 'vue'
export default {
  props: {
    architecture: {
      type: Object,
      default: () => ({})
    }
  },
  data() {
    return {
      loading: false,
      lat: '',
      lng: '',
      options: {
        mapTypeControl: false,
        streetViewControl: false
      }
    }
  },
  mounted() {
    Vue.$geocoder.send(
      { address_line_1: this.architecture.address },
      (response) => {
        if (response.results) {
          this.lat = response.results[0].geometry.location.lat
          this.lng = response.results[0].geometry.location.lng
          console.log(response.results[0].geometry)
          this.loading = true
        }
      }
    )
  }
}
</script>