<template>
  <div>
    <v-toolbar dense flat color="tertiary">
      <v-toolbar-title
        class="text-subtitle-1
        text-sm-h6
        text-md-h5
        text--primary
        mx-auto"
      >
        コメント
      </v-toolbar-title>
    </v-toolbar>
    <v-card-text>
      <v-form>
        <v-textarea
          v-model="content"
          dense
          outlined
          height="100"
          placeholder="コメントを入力"
          counter="150"
        />
      </v-form>
    </v-card-text>
    <v-card-actions class="pa-4 pt-0">
      <v-spacer />
      <v-btn
        :disabled="able"
        :small="btnSize"
        color="tertiary"
        class="primary--text"
        @click="userCommentCreate"
      >
        送信
      </v-btn>
    </v-card-actions>
  </div>
</template>

<script>
import { mapGetters, mapActions } from 'vuex'
export default {
  props: {
    post: {
      type: Object,
      required: true
    }
  },
  data() {
    return {
      content: ''
    }
  },
  computed: {
    ...mapGetters('authentication', [
      'currentUser'
    ]),
    able() {
      if (this.content === '') {
        return true
      } else if (this.content.length > 150) {
        return true
      } else {
        return false
      }
    },
    btnSize() {
      if (this.$vuetify.breakpoint.xsOnly) {
        return true
      } else {
        return false
      }
    }
  },
  methods: {
    ...mapActions({
      messageShow: 'snackbarMessage/messageShow',
      postGet: 'post/postGet'
    }),
    async commentCreate() {
      const response = await this.$axios
        .post('/api/v1/comments', {
          user_id: this.currentUser.id,
          post_id: this.post.id,
          content: this.content
        })
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async userCommentCreate() {
      const res = await this.commentCreate()
      if (!res) {
        return
      }
      this.postGet(this.post.id)
      this.content = ''
      this.messageShow({
        message: '投稿にコメントしました',
        type: 'success',
        status: true
      })
    }
  }
}
</script>
