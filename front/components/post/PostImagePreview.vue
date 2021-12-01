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
    <v-img
      :src="image"
      contain
      max-height="400"
    />
  </v-card>
</template>

<script>
export default {
  props: {
    image: {
      type: String,
      default: null
    }
  },
  methods: {
    closeDialog() {
      this.$emit('close')
    }
  }
}
</script>
