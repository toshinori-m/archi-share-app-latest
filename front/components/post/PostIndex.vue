<template>
  <div>
    <div class="d-flex justify-space-between flex-wrap mt-5">
      <v-card
        v-for="post in viewLists"
        :key="post.id"
        width="250"
        class="mb-10"
        @click="postClick(post)"
      >
        <v-img
          :src="post.image.url"
          width="250"
          height="200"
        />
        <p class="font-weight-bold text-truncate text-center ma-1 mb-0">
          {{ post.title }}
        </p>
        <div
          class="d-inline-block ml-1 mb-1"
          @click.stop="userClick(post.user)"
        >
          <v-avatar size="50">
            <v-img :src="post.user.image.url" />
          </v-avatar>
          {{ post.user.name }}
        </div>
        <div class="d-flex justify-end">
          <like-button :post="post" />
        </div>
      </v-card>
    </div>
    <v-pagination v-model="page" :length="pageLength" />
  </div>
</template>

<script>
import LikeButton from '~/components/like/LikeButton.vue'
export default {
  components: {
    LikeButton
  },
  props: {
    posts: {
      type: Array,
      required: true
    },
  },
  data() {
    return {
      page: 1,
      pageSize: 4
    }
  },
  computed: {
    pageLength() {
      const length = Math.ceil(this.posts.length / this.pageSize)
      return length
    },
    viewLists() {
      const lists = this.posts.slice(
        this.pageSize * (this.page - 1),
        this.pageSize * this.page
      )
      return lists
    },
    loadPost() {
      return this.$store.getters['post/post']
    },
  },
   watch: {
    loadPost() {
      this.$emit('load')
    }
  },
  methods: {
    postClick(post) {
      this.$router.push(`/posts/${post.id}`)
    },
    userClick(user) {
      this.$router.push(`/users/${user.id}`)
    }
  }
}
</script>
