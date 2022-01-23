<template>
  <v-card>
    <template v-if="posts[0]">
      <v-card
        v-for="(post, i) in posts"
        :key="post.id"
        tile
        flat
        @click="postClick(post)"
      >
        <v-card-actions>
          <div
            class="d-inline-block text-truncate"
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
        <div class="pa-4 pb-0">
          <v-row justify="center" algin="center">
            <v-col cols="12" sm="5" align-self="center">
              <v-img
                :src="post.image.url"
                contain
                max-height="300px"
              />
            </v-col>
            <v-col cols="12" sm="7">
              <v-card-title class="justify-center">
                <span class="text-truncate">{{ post.title }}</span>
              </v-card-title>
              <v-card-text>
                <p>
                  {{ post.content }}
                </p>
              </v-card-text>
            </v-col>
          </v-row>
        </div>
        <v-row
          dense
          justify="end"
          align="center"
          class="pr-10"
        >
          <v-col cols="4">
            <like-button
              :post="post"
              class="justify-end"
            />
          </v-col>
          <v-col cols="4">
            <comment-count
              :comments="post.comments"
              class="justify-end"
            />
          </v-col>
          <v-col cols="4" class="text-right">
            <elapsed-time :content="post" />
          </v-col>
        </v-row>
        <v-divider v-if="i !== posts.length - 1" />
      </v-card>
    </template>
    <template v-else>
      <v-card tile outlined>
        <v-card-text>
          <p class="text-h5 text-center mb-0">{{ user.name }}がいいねした投稿はありません</p>
        </v-card-text>
      </v-card>
    </template>
  </v-card>
</template>

<script>
import LikeButton from '~/components/like/LikeButton.vue'
import CommentCount from '~/components/comment/CommentCount.vue'
import ElapsedTime from '~/components/time/ElapsedTime.vue'
export default {
  components: {
    LikeButton,
    CommentCount,
    ElapsedTime
  },
  props: {
    user: {
      type: Object,
      required: true
    },
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
  methods: {
    userClick(post) {
      if (this.user.id !== post.user.id ) {
        this.$router.push(`/users/${post.user.id}`)
      } else {
        this.$vuetify.goTo(0)
      }
    },
    postClick(post) {
      this.$router.push(`/posts/${post.id}`)
    }
  }
}
</script>
