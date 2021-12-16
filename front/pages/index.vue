<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="8" md="6">
      <v-card class="text-center">
        <v-card-title class="headline justify-center">
          ArchiShare App
        </v-card-title>
        <v-card-subtitle>
          This is an architectural learning app
        </v-card-subtitle>
        <v-card-text>
          <p v-if="login">{{ currentUser.name }}がログインしています</p>
          <p v-else>まだログインしていません</p>
        </v-card-text>
      </v-card>
      <post-index
        :posts="posts"
        :post="post"
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
      posts: 'post/posts',
      post: 'post/post'
    })
  },
  methods: {
    ...mapActions('post', [
      'postsGet'
    ])
  }
}
</script>
