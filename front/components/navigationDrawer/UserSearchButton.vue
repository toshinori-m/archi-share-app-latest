<template>
  <v-tooltip right>
    <template #activator="{ on, attrs }">
      <v-btn
          icon
          large
          v-bind="attrs"
          v-on="on"
          @click="userSearchClick"
        >
          <v-icon color="white">mdi-account-search</v-icon>
        </v-btn>
    </template>
    <span class="text-caption">ユーザー検索</span>
  </v-tooltip>
</template>

<script>
export default {
  methods: {
    userSearchClick() {
      this.$router.push('/users/search')
    }
  }
}
</script>
