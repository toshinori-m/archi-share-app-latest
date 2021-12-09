<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="9" md="7">
      <v-card>
        <v-card-actions>
          <div class="link" @click="userClick">
            <v-avatar size="50" class="ma-2">
              <v-img
                v-if="post.user.image.url"
                :src="post.user.image.url"
              />
              <v-else v-else :src="icon" />
            </v-avatar>
            <span>
              {{ post.user.name }}
            </span>
          </div>
          <v-spacer />
          <span class="text-h6 grey--text text--darken-1 mr-5">
            {{ postCreatedTime }}
          </span>
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
        <v-divider />
        <comment-form :post="post" />
        <v-divider />
        <comment-list :comments="post.comments" />
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters } from 'vuex'
import dayjs from 'dayjs'
import PostSettingButton from '~/components/post/PostSettingButton.vue'
import LikeButton from '~/components/like/LikeButton.vue'
import LikeUserModal from '~/components/like/LikeUserModal.vue'
import CommentForm from '~/components/comment/CommentForm.vue'
import CommentList from '~/components/comment/CommentList.vue'
export default {
  components: {
    PostSettingButton,
    LikeButton,
    LikeUserModal,
    CommentForm,
    CommentList
  },
  data() {
    return {
      icon: require('@/assets/images/default.png')
    }
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
    }),
    postCreatedTime() {
      const time = dayjs(this.post.created_at).format('YYYY-MM-DD')
      return time
    }
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
