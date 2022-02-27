<template>
  <v-btn :block="block" :color="color" :class="className" @click="onClick">
    {{ text }}
  </v-btn>
</template>

<script>
export default {
  props: {
    text: {
      type: String,
      required: true
    },
    block: {
      type: Boolean,
      default: false
    },
    color: {
      type: String,
      required: true
    },
    className: {
      type: String,
      default: ''
    },
    onClick: {
      type: Function,
      default: () => ({})
    }
  }
}
</script>
