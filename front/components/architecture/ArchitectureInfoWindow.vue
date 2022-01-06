<template>
  <v-card @click="windowClick">
    <v-card-title class="justify-center">
      <span class="text-subtitle-1">
        {{ architecture.name }}
      </span>
    </v-card-title>
  </v-card>
</template>

<script>
export default {
  props: {
    architecture: {
      type: Object,
      required: true
    }
  },
  methods: {
    windowClick() {
      this.$router.push('/posts/search')
    }
  }
}
</script>
