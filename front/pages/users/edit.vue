<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="7" md="5">
      <user-edit />
    </v-col>
  </v-row>
</template>

<script>
import UserEdit from '~/components/user/UserEdit.vue'
export default {
  components: {
    UserEdit
  }
}
</script>
