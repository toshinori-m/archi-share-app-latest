<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="9" md="7">
      <v-card>
        <v-card-actions>
          <div @click="userClick" class="link">
            <v-avatar size="50" class="ma-2">
              <v-img :src="post.user.image.url" />
            </v-avatar>
            <span>
              {{ post.user.name }}
            </span>
          </div>
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
        <v-card-actions class="px-4">
          <like-button :post="post" />
          <like-user-modal :users="post.like_users" />
        </v-card-actions>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters } from 'vuex'
import PostSettingButton from '~/components/post/PostSettingButton.vue'
import LikeButton from '~/components/like/LikeButton.vue'
import LikeUserModal from '~/components/like/LikeUserModal.vue'
export default {
  components: {
    PostSettingButton,
    LikeButton,
    LikeUserModal
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
  },
  methods: {
    userClick() {
      this.$router.push(`/users/${this.post.user.id}`)
    }
  }
}
</script>

<style scoped>
.link {
  cursor: pointer;
}
</style>
