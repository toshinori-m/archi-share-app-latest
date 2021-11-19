<template>
  <v-card>
    <v-card-title class="justify-center">
      <span class="text-h5 text-weight-bold">アカウント削除</span>
    </v-card-title>
    <v-card-text>
      <p class="text-center">アカウントを削除すると以下のデータが全て消えてしまいます</p>
      <v-list-item v-for="(item, i) in items" :key="i">
        <v-list-item-content>
          <v-list-item-title v-text="item.title"></v-list-item-title>
          <v-list-item-subtitle v-text="item.text"></v-list-item-subtitle>
        </v-list-item-content>
      </v-list-item>
    </v-card-text>
    <v-card-actions class="ml-5">
      <v-checkbox
        v-model="checkbox"
        label="アカウントの削除に同意する"
      ></v-checkbox>
    </v-card-actions>
    <v-card-actions class="justify-center">
      <user-delete-modal :disable="!checkbox"/>
    </v-card-actions>
  </v-card>
</template>

<script>
import UserDeleteModal from '~/components/user/UserDeleteModal.vue'
export default {
  components: {
    UserDeleteModal
  },
  data() {
    return {
      items: [
        {
          title: 'ユーザー情報',
          text: '名前、メールアドレス、パスワード、ユーザー画像'
        },
        {
          title: '投稿',
          text: 'あなたの投稿、コメント、いいね'
        }
      ],
      checkbox: false
    }
  }
}
</script>
