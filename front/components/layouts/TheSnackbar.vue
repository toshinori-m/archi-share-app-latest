<template>
  <v-snackbar
    v-model="status"
    app
    top
    left
    text
    :color="type"
  >
    {{ message }}
  </v-snackbar>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  computed: {
    ...mapGetters('snackbarMessage', [
      'message',
      'type',
      'status'
    ])
  }
}
</script>
