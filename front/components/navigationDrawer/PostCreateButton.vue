<template>
  <v-tooltip right>
    <template #activator="{ on, attrs }">
      <v-btn
        icon
        large
        v-bind="attrs"
        v-on="on"
        @click="createButtonClick"
      >
        <v-icon color="white">mdi-note-plus</v-icon>
      </v-btn>
    </template>
    <span class="text-caption">新規投稿</span>
  </v-tooltip>
</template>

<script>
export default {
  methods: {
    createButtonClick() {
      this.$router.push('/posts/new')
    }
  }
}
</script>
