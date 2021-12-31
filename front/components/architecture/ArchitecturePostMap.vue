<template>
  <div class="px-2">
    <GmapMap
      :center="{
        lat: Number(architecture.lat),
        lng: Number(architecture.lng)
      }"
      :zoom="17"
      :options="options"
      map-type-id="roadmap"
      style="height: 300px"
    >
      <GmapMarker
        :position="{
          lat: Number(architecture.lat),
          lng: Number(architecture.lng)
        }"
      />
    </GmapMap>
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
      options: {
        mapTypeControl: false,
        streetViewControl: false
      }
    }
  }
}
</script>