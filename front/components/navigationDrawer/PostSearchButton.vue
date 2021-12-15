<template>
  <v-tooltip right>
    <template #activator="{ on, attrs }">
      <v-btn
          icon
          large
          v-bind="attrs"
          v-on="on"
          @click="searchButtonClick"
        >
          <v-icon color="white">mdi-file-search</v-icon>
        </v-btn>
    </template>
    <span class="text-caption">投稿検索</span>
  </v-tooltip>
</template>

<script>
export default {
  methods: {
    searchButtonClick() {
      this.$router.push('/posts/search')
    }
  }
}
</script>
