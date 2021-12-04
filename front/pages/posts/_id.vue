<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="9" md="7">
      <v-card>
        <v-card-actions>
          <v-avatar size="50" class="ma-2">
            <v-img :src="post.user.image.url" />
          </v-avatar>
          <span>
            {{ post.user.name }}
          </span>
          <v-spacer />
          <post-setting-button v-if="login" />
        </v-card-actions>
        <v-divider />
        <v-img :src="post.image.url" contain max-height="400" />
        <v-divider />
        <v-card-title>
          <span class="headline">{{ post.title }}</span>
        </v-card-title>
        <v-card-text class="text--primary">
          {{ post.content }}
        </v-card-text>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters } from 'vuex'
import PostSettingButton from '~/components/post/PostSettingButton.vue'
export default {
  components: {
    PostSettingButton
  },
  async fetch({ $axios, params, store }) {
    await $axios
      .$get(`/api/v1/posts/${params.id}`)
      .then((res) => {
        console.log(res)
        store.commit('post/postSet', res)
      })
      .catch((e) => {
        console.log(e)
      })
  },
  head() {
    return {
      title: '投稿詳細'
    }
  },
  computed: {
    ...mapGetters({
      post: 'post/post',
      login: 'authentication/login'
    })
  }
}
</script>
