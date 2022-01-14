<template>
  <v-progress-linear
    :active="linear"
    indeterminate
    color="tertiary"
  />
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters('progressLinear', [
      'linear'
    ])
  }
}
</script>