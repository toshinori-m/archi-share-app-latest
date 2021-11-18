<template>
  <v-tooltip right>
    <template #activator="{ on, attrs }">
      <v-btn
          icon
          large
          v-bind="attrs"
          v-on="on"
          @click="homeButtonClick"
        >
          <v-icon color="white">mdi-home</v-icon>
        </v-btn>
    </template>
    <span class="text-caption">ホーム</span>
  </v-tooltip>
</template>

<script>
export default {
  methods: {
    homeButtonClick() {
      this.$router.push('/')
    }
  }
}
</script>
