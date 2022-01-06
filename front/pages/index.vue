<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="10" md="10">
      <post-index
        :posts="posts"
        :tool-title="toolTitle"
        @load="postsGet"
      />
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
import PostIndex from '~/components/post/PostIndex.vue'
export default {
  components: {
    PostIndex
  },
  data() {
    return {
      toolTitle: '最近の投稿'
    }
  },
  async fetch({ $axios, store }) {
    await $axios
      .$get('/api/v1/posts')
      .then((res) => {
        store.commit('post/postsSet', res)
      })
      .catch((e) => {
        console.log(e)
      })
  },
  head() {
    return {
      title: 'ホーム',
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser',
      login: 'authentication/login',
      posts: 'post/posts'
    })
  },
  methods: {
    ...mapActions('post', [
      'postsGet'
    ])
  }
}
</script>
