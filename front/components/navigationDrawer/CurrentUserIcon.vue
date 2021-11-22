<template>
  <v-tooltip right>
    <template #activator="{ on, attrs }">
      <v-img
        v-if="currentUser.image.url"
        :src="currentUser.image.url"
        v-bind="attrs"
        v-on="on"
        @click="iconClick"
      />
      <v-img
        v-else
        :src="icon"
        v-bind="attrs"
        v-on="on"
        @click="iconClick"
      />
    </template>
    <span class="text-caption">マイページ</span>
  </v-tooltip>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  data() {
    return {
      icon: require('@/assets/images/default.png')
    }
  },
  computed: {
    ...mapGetters('authentication', [
      'currentUser'
    ])
  },
  methods: {
    iconClick() {
      this.$router.push(`/users/${this.currentUser.id}`)
    }
  }
}
</script>
