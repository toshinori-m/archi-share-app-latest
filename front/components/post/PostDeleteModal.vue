<template>
  <v-card>
    <v-card-title class="justify-center">
      <span class="primary--text">投稿削除の確認</span>
    </v-card-title>
    <v-card-text class="primary--text text-center">
      <p>本当にこの投稿を削除してもよろしいですか？</p>
    </v-card-text>
    <v-card-actions>
      <v-btn
        block
        color="tertiary"
        @click="userPostDelete"
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
import { mapGetters, mapActions } from 'vuex'
export default {
  computed: {
    ...mapGetters('post', [
      'post'
    ])
  },
  methods: {
    ...mapActions('snackbarMessage', [
      'messageShow'
    ]),
    closeDialog() {
      this.$emit('close')
    },
    async postDelete() {
      const response = await this.$axios
        .delete(`/api/v1/posts/${this.post.id}`)
        .catch((e) => {
          console.log(e)
        })
      return response
    },
    async userPostDelete() {
      const res = await this.postDelete()
      if (!res) {
        return
      }
      this.$router.go(-1)
      this.messageShow({
        message: '投稿を削除しました',
        type: 'success',
        status: true
      })
    }
  }
}
</script>
