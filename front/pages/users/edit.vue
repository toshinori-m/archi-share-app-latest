<template>
  <v-row justify="center" justify-lg="start" align="center">
    <v-col v-if="$vuetify.breakpoint.lgAndUp" lg="3" align-self="start">
      <v-card>
        <v-list>
          <v-list-item-group
            v-model="selectedItem"
            mandatory
            color="accent"
          >
            <v-list-item v-for="(item, i) in items" :key="i">
              <v-list-item-icon>
                <v-icon v-text="item.icon"></v-icon>
              </v-list-item-icon>
              <v-list-item-title
                v-text="item.text"
                class="primary--text"
              ></v-list-item-title>
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-card>
    </v-col>
    <v-col cols="12" sm="10" md="8" lg="6">
      <template v-if="$vuetify.breakpoint.mdAndDown">
        <v-bottom-navigation
          v-model="selectedItem"
          grow
          color="accent"
        >
          <v-btn>
            <span>ユーザー情報編集</span>
            <v-icon>mdi-account-edit</v-icon>
          </v-btn>
          <v-btn>
            <span>パスワード変更</span>
            <v-icon>mdi-lock</v-icon>
          </v-btn>
          <v-btn>
            <span>アカウント削除</span>
            <v-icon>mdi-account-remove</v-icon>
          </v-btn>
        </v-bottom-navigation>
      </template>
      <user-edit v-if="selectedItem === 0" />
      <user-edit-password v-if="selectedItem === 1" />
      <user-delete v-if="selectedItem === 2" />
    </v-col>
  </v-row>
</template>

<script>
import UserEdit from '~/components/user/UserEdit.vue'
import UserEditPassword from '~/components/user/UserEditPassword.vue'
import UserDelete from '~/components/user/UserDelete.vue'
export default {
  components: {
    UserEdit,
    UserEditPassword,
    UserDelete
  },
  data() {
    return {
      selectedItem: 0,
      items: [
        { text: 'ユーザー情報編集', icon: 'mdi-account-edit' },
        { text: 'パスワード変更', icon: 'mdi-lock' },
        { text: 'アカウント削除', icon: 'mdi-account-remove' }
      ],
      value: 0
    }
  },
  head() {
    return {
      title: 'アカウント編集',
    }
  },
}
</script>
