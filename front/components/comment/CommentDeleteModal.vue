<template>
  <v-card>
    <v-card-title class="justify-center">
      <span class="primary--text">
        コメント削除の確認
      </span>
    </v-card-title>
    <v-card-text class="black--text text-center">
      <p class="primary--text">
        本当にこのコメントを削除してもよろしいですか？
      </p>
    </v-card-text>
    <v-card-actions>
      <v-btn
        block
        color="tertiary"
        @click="userCommentDelete"
      >
        はい
      </v-btn>
    </v-card-actions>
    <v-card-actions class="pb-4">
      <v-btn
        block
        color="grey lighten-2"
        @click="closeDialog"
      >
        いいえ
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
import { mapActions } from 'vuex'
export default {
  props: {
    comment: {
      type: Object,
      required: true
    }
  },
  methods: {
    ...mapActions({
      postGet: 'post/postGet',
      messageShow: 'snackbarMessage/messageShow'
    }),
    closeDialog() {
      this.$emit('close')
    },
    async commentDelete() {
      const response = await this.$axios
        .delete(`/api/v1/comments/${this.comment.id}`)
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async userCommentDelete() {
      const res = await this.commentDelete()
      if (!res) {
        return
      }
      this.postGet(this.comment.post.id)
      this.$emit('close')
      this.messageShow({
        message: 'コメントを削除しました',
        type: 'success',
        status: true
      })
    }
  }
}
</script>
