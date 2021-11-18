<template>
  <v-tooltip bottom>
    <template #activator="{ on, attrs }">
      <v-btn
          icon
          large
          v-bind="attrs"
          v-on="on"
          @click="userEditClick"
        >
          <v-icon color="white">mdi-account-edit</v-icon>
        </v-btn>
    </template>
    <span class="text-caption">アカウント編集</span>
  </v-tooltip>
</template>

<script>
export default {
  methods: {
    userEditClick() {
      this.$router.push('/users/edit')
    }
  }
}
</script>
