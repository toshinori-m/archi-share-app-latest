<template>
  <div>
    <template v-if="user.posts[0]">
      <v-card
        v-for="post in user.posts"
        :key="post.id"
        tile
        outlined
        @click="postClick(post)"
      >
        <v-card-actions>
          <div
            class="d-inline-block"
            @click.stop="userClick(user)"
          >
            <v-avatar size="50" class="mr-2">
              <v-img v-if="user.image.url" :src="user.image.url" />
              <v-img v-else :src="icon" />
            </v-avatar>
            <span>
              {{ user.name }}
            </span>
          </div>
          <v-spacer />
          <elapsed-time :content="post" />
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
    </template>
    <template v-else>
      <v-card tile outlined>
        <v-card-text>
          <p class="text-h5 text-center mb-0">{{ user.name }}の投稿はありません</p>
        </v-card-text>
      </v-card>
    </template>
  </div>
</template>

<script>
import LikeButton from '~/components/like/LikeButton.vue'
import ElapsedTime from '~/components/time/ElapsedTime.vue'
export default {
  components: {
    LikeButton,
    ElapsedTime
  },
  filters: {
    filteredContent(post) {
      return post.content.length > 50 ? post.content.slice(0, 50) + '...' : post.content
    }
  },
  props: {
    user: {
      type: Object,
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
    userClick(user) {
      this.$router.push(`/users/${user.id}`)
    },
    postClick(post) {
      this.$router.push(`/posts/${post.id}`)
    }
  }
}
</script>

