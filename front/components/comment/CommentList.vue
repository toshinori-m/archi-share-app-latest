<template>
  <div>
    <div
      v-for="comment in comments"
      :key="comment.id"
    >
      <div
        class="d-inline-block link"
        @click="userClick(comment.user)"
      >
        <v-avatar size="40" class="ma-2">
          <v-img
            v-if="comment.user.image.url"
            :src="comment.user.image.url"
          />
          <v-img v-else :src="icon" />
        </v-avatar>
        <span>{{ comment.user.name }}</span>
      </div>
      <p class="px-5">{{ comment.content }}</p>
      <v-divider />
    </div>
  </div>
</template>

<script>
export default {
  props: {
    comments: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      icon: require('@/assets/images/default.png')
    }
  },
  methods: {
    userClick(user) {
      this.$router.push(`/users/${user.id}`)
    }
  }
}
</script>

<style scoped>
.link {
  cursor: pointer;
}
</style>
