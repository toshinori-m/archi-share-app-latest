<template>
  <v-navigation-drawer
    v-model="navigation"
    app
  >
    <v-list v-if="login">
      <v-list-item :to="{ name: 'users-id', params: { id: currentUser.id } }">
        <v-list-item-avatar>
          <v-img
            v-if="currentUser.image.url"
            :src="currentUser.image.url"
          />
          <v-img v-else :src="icon" />
        </v-list-item-avatar>
        <v-list-item-content>
          <v-list-item-title>
            {{ currentUser.name }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
      <v-list-item
        v-for="(item, i) in items1"
        :key="i"
        :to="item.route"
        color="primary"
      >
        <v-list-item-icon>
          <v-icon color="primary">
            {{ item.icon }}
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title class="primary--text">
            {{ item.text }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
    <v-list v-else>
      <v-list-item
        v-for="(item, i) in items2"
        :key="i"
        :to="item.route"
        color="primary"
      >
        <v-list-item-icon>
          <v-icon color="primary">
            {{ item.icon }}
          </v-icon>
        </v-list-item-icon>
        <v-list-item-content>
          <v-list-item-title class="primary--text">
            {{ item.text }}
          </v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import { mapGetters } from 'vuex'
export default {
  data() {
    return {
      icon: require('@/assets/images/default.png'),
      items1: [
        { icon: 'mdi-home', text: 'ホーム', route: '/' },
        { icon: 'mdi-timeline', text: 'タイムライン', route: '/posts/timeline' },
        { icon: 'mdi-note-plus', text: '新規投稿', route: '/posts/new' },
        { icon: 'mdi-file-search', text: '投稿検索', route: '/posts/search' },
        { icon: 'mdi-map-search', text: '建築物を探す', route: '/architectures/search' },
        { icon: 'mdi-account-search', text: 'ユーザー検索', route: '/users/search' },
        { icon: 'mdi-account-edit', text: 'アカウント編集', route: '/users/edit' }
      ],
      items2: [
        { icon: 'mdi-home', text: 'ホーム', route: '/' },
        { icon: 'mdi-file-search', text: '投稿検索', route: '/posts/search' },
        { icon: 'mdi-map-search', text: '建築物を探す', route: '/architectures/search' },
        { icon: 'mdi-account-search', text: 'ユーザー検索', route: '/users/search' }
      ]
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser',
      login: 'authentication/login',
      drawer: 'navigationDrawer/drawer'
    }),
    navigation: {
      get() {
        return this.drawer
      },
      set(value) {
        return value
      }
    }
  }
}
</script>
