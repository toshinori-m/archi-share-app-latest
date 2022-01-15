<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="10" md="10">
      <post-index
        :posts="feed"
        :tool-title="toolTitle"
      />
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
import PostIndex from '~/components/post/PostIndex.vue'
export default {
  components: {
    PostIndex
  },
  data() {
    return {
      toolTitle: 'タイムライン'
    }
  },
  async fetch({ $axios, store }) {
    await $axios
      .$get('/api/v1/posts/timeline')
      .then((res) => {
        store.commit('post/feedSet', res)
      })
      .catch((e) => {
        console.log(e)
      })
  },
  head() {
    return {
      title: 'タイムライン',
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser',
      login: 'authentication/login',
      feed: 'post/feed',
      post: 'post/post'
    }),
    postCheck() {
      return this.post
    }
  },
  watch: {
    postCheck() {
      this.feedUpdate(this.post)
    }
  },
  methods: {
    ...mapMutations('post', [
      'feedUpdate'
    ])
  }
}
</script>
