<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="10" md="10">
      <v-card flat>
        <v-img :src="image" height="600" class="mb-2">
          <v-card-text class="primary--text">
            <p class="text-h3 mb-10">ArchiShare</p>
            <span class="text-h5">
              建築を学ぶ人同士が
            </span>
            <br />
            <span class="text-h5">
              参考になる建築物や情報を共有するアプリです
            </span>
          </v-card-text>
          <v-card-actions class="px-4">
            <v-btn color="secondary" @click="helpClick">
              操作方法
            </v-btn>
          </v-card-actions>
        </v-img>
      </v-card>
      <v-toolbar flat color="tertiary">
        <v-toolbar-title>
          評価の高い投稿
        </v-toolbar-title>
      </v-toolbar>
      <the-carousel :items="rank" />
      <post-index
        :posts="posts"
        :tool-title="toolTitle"
      />
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapMutations, mapActions } from 'vuex'
import TheCarousel from '~/components/layouts/TheCarousel.vue'
import PostIndex from '~/components/post/PostIndex.vue'
export default {
  components: {
    TheCarousel,
    PostIndex
  },
  data() {
    return {
      toolTitle: '最近の投稿',
      image: require('@/assets/images/lp.jpg')
    }
  },
  async fetch({ app, store }) {
    await Promise.all([
      app.$axios.$get('/api/v1/posts')
        .then((res) => {
          store.commit('post/postsSet', res)
        })
        .catch((e) => {
          console.log(e)
        }),
      app.$axios.$get('/api/v1/posts/rank')
        .then((res) => {
          store.commit('post/rankSet', res)
        })
        .catch((e) => {
          console.log(e)
        })
    ])
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
      post: 'post/post',
      rank: 'post/rank'
    }),
    postCheck() {
      return this.post
    }
  },
  watch: {
    postCheck() {
      this.postsUpdate(this.post)
    }
  },
  methods: {
    ...mapMutations('post', [
      'postsUpdate'
    ]),
    ...mapActions('post', [
      'postsGet'
    ]),
    helpClick() {
      this.$router.push('/help')
    }
  }
}
</script>
