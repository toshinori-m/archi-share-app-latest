<template>
  <v-row>
    <v-col>
      <v-card>
        <v-card-text class="primary--text text-subtitle-1">
          <span>
            画面左上の三本線のアイコンを選択することで各ページに移動することが出来ます!
            <br />
            まずは「建築物を探す」のページに移動してマップ上からマーカーを選択してみましょう!
            </span>
            <v-img :src="image" />
            各ページの簡単な説明は以下に記載します。
        </v-card-text>
        <v-expansion-panels v-model="panel" multiple flat>
          <v-expansion-panel>
            <v-expansion-panel-header class="text-h6 primary--text">
              新規登録・ログインについて
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              画面右上のボタンをクリックする事で新規登録・ログインフォームが表示されます。
              <br />
              ゲストユーザーとして簡単にログインすることも出来ます。
            </v-expansion-panel-content>
          </v-expansion-panel>
          <v-expansion-panel>
            <v-expansion-panel-header class="text-h6 primary--text">
              タイムライン
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              自分または自分がフォローしているユーザーの投稿を見ることが出来ます。
              <br />
              まだ、ユーザーをフォローしていない方はユーザー検索から気になるユーザーを見つけてみよう!
            </v-expansion-panel-content>
          </v-expansion-panel>
          <v-expansion-panel>
            <v-expansion-panel-header class="text-h6 primary--text">
              新規投稿
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              共有したい内容を投稿することが出来ます。
              また、建築物のデータを紐付けしたい場合は選択することが可能です。
              <br />
              自由に投稿してみましょう!
            </v-expansion-panel-content>
          </v-expansion-panel>
          <v-expansion-panel>
            <v-expansion-panel-header class="text-h6 primary--text">
              投稿検索
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              投稿を検索することが出来ます。投稿に建築物が紐づいている場合は建築物での検索も可能です。
            </v-expansion-panel-content>
          </v-expansion-panel>
          <v-expansion-panel>
            <v-expansion-panel-header class="text-h6 primary--text">
              建築物を探す
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              マップ上でマーカーを選択することで、選択した建築物のデータや関連する投稿を見ることが出来ます。
              <br />
              また、絞り込み検索を利用して条件に該当する建築物を探すことも出来ます。
            </v-expansion-panel-content>
          </v-expansion-panel>
          <v-expansion-panel>
            <v-expansion-panel-header class="text-h6 primary--text">
              ユーザー検索
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              アプリを利用しているユーザーを検索することが出来ます。
              <br />
              気になるユーザーがいたらフォローボタンを押してフォローしてみよう!
            </v-expansion-panel-content>
          </v-expansion-panel>
          <v-expansion-panel>
            <v-expansion-panel-header class="text-h6 primary--text">
              アカウント編集
            </v-expansion-panel-header>
            <v-expansion-panel-content>
              プロフィールの編集、パスワードの変更、アカウントの削除を行うことが出来ます。
              <br />
              ただし、ゲストユーザーは変更・更新することは出来ません。
            </v-expansion-panel-content>
          </v-expansion-panel>
        </v-expansion-panels>
        <v-card-actions class="justify-center">
          <v-btn
            color="tertiary"
            class="primary--text"
            @click="returnButton"
          >
            TOPページに戻る
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
export default {
  data() {
    return {
      panel: null,
      image: require('@/assets/images/operation.png')
    }
  },
  head() {
    return {
      title: '操作方法',
    }
  },
  methods: {
    returnButton() {
      this.$router.push('/')
    }
  }
}
</script>
