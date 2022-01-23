<template>
  <div class="d-flex align-center">
    <span class="text-h6">
      {{ comments.length }}
    </span>
    <v-icon class="ml-1">
      mdi-comment
    </v-icon>
  </div>
</template>

<script>
export default {
  props: {
    comments: {
      type: Array,
      required: true
    }
  }
}
</script>
