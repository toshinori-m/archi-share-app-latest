<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="10" lg="8">
      <v-card>
        <v-row dense justify="center" align="center">
          <v-col cols="6" sm="8">
            <div class="link text-truncate" @click="userClick">
              <v-avatar :size="avatarSize" class="ma-2">
                <v-img
                  v-if="post.user.image.url"
                  :src="post.user.image.url"
                />
                <v-else v-else :src="icon" />
              </v-avatar>
              <span class="text-caption text-sm-subtitle-1">
                {{ post.user.name }}
              </span>
            </div>
          </v-col>
          <v-col cols="6" sm="4" class="text-center">
            <v-card-actions class="justify-end">
              <span
                class="text-caption
                text-sm-subtitle-1
                text-md-h6
                text-sm-right
                grey--text
                text--darken-1"
              >
                {{ postCreatedTime }}
              </span>
              <post-setting-button v-if="login" />
            </v-card-actions>
          </v-col>
        </v-row>
        <v-divider />
        <v-img :src="post.image.url" contain max-height="400" />
        <v-divider />
        <v-card-title>
          <span class="text-subtitle-1 text-sm-h5">{{ post.title }}</span>
        </v-card-title>
        <v-card-text
          class="text--primary text-caption text-sm-subtitle-1"
          :style="{'white-space': 'pre-line'}"
        >
          {{ post.content }}
        </v-card-text>
        <v-card-actions class="px-4">
          <like-button :post="post" />
          <like-user-modal :users="post.like_users" />
        </v-card-actions>
        <architecture-post-show
          v-if="post.architecture"
          :architecture="post.architecture"
        />
        <comment-form :post="post" />
        <v-divider />
        <comment-list v-if="post.comments" :comments="post.comments" />
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
import ArchitecturePostShow from '~/components/architecture/ArchitecturePostShow.vue'
import CommentForm from '~/components/comment/CommentForm.vue'
import CommentList from '~/components/comment/CommentList.vue'
export default {
  components: {
    PostSettingButton,
    LikeButton,
    LikeUserModal,
    ArchitecturePostShow,
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
    avatarSize() {
      if (this.$vuetify.breakpoint.smAndUp) {
        return 50
      } else {
        return 35
      }
    },
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
