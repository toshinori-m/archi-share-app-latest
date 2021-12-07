<template>
  <div>
    <v-card
      v-for="post in posts"
      :key="post.id"
      tile
      outlined
      @click="postClick(post)"
    >
      <v-card-actions>
        <div
          class="d-inline-block"
          @click.stop="userClick(post)"
        >
          <v-avatar size="50" class="mr-2">
            <v-img v-if="post.user.image.url" :src="post.user.image.url" />
            <v-img v-else :src="icon" />
          </v-avatar>
          <span>
            {{ post.user.name }}
          </span>
        </div>
      </v-card-actions>
      <div class="pa-4">
        <v-row algin="center">
          <v-col cols="6" align-self="center">
            <v-img
              :src="post.image.url"
              contain
              max-height="250"
            />
          </v-col>
          <v-col cols="6">
            <v-responsive max-height="210">
              <v-card-title class="justify-center">
                <span class="text-truncate">{{ post.title }}</span>
              </v-card-title>
              <v-card-text>
                <p class="overflow-y-hidden">
                  {{ post | filteredContent }}
                </p>
              </v-card-text>
              <div>
                <like-button :post="post" />
              </div>
            </v-responsive>
          </v-col>
        </v-row>
      </div>
    </v-card>
  </div>
</template>

<script>
import LikeButton from '~/components/like/LikeButton.vue'
export default {
  componens: {
    LikeButton
  },
  filters: {
    filteredContent(post) {
      return post.content.length > 50 ? post.content.slice(0, 50) + '...' : post.content
    }
  },
  props: {
    posts: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      icon: require('@/assets/images/default.png')
    }
  },
  computed: {
    loadPost() {
      return this.$store.getters['post/post']
    }
  },
  watch: {
    loadPost() {
      this.$emit('load')
    }
  },
  methods: {
    userClick(post) {
      this.$router.push(`/users/${post.user.id}`)
    },
    postClick(post) {
      this.$router.push(`/posts/${post.id}`)
    }
  }
}
</script>
