<template>
  <v-row justify="center" algin="center">
    <v-col cols="12" sm="8" md="6">
      <v-card>
        <v-card-title class="justify-center">
          <span>ユーザー検索</span>
        </v-card-title>
        <v-card-text>
          <v-form>
            <v-text-field
              v-model="filterQuery.name"
              placeholder="ニックネームで検索"
              prepend-icon="mdi-lead-pencil"
            />
          </v-form>
        </v-card-text>
        <v-card-actions>
          <v-btn
            block
            color="light-blue lighten-2"
            @click="handleChangeQuery"
          >
          検索
          </v-btn>
        </v-card-actions>
      </v-card>
      <v-card class="mt-5">
        <template v-if="viewLists[0]">
          <v-list>
            <v-list-item
              v-for="(user) in viewLists"
              :key="user.id"
              @click="userShowClick(user)"
            >
              <v-list-item-avatar size="60">
                <v-img v-if="user.image.url" :src="user.image.url" />
                <v-img v-else :src="icon" />
              </v-list-item-avatar>
              <v-list-item-content>
                <span>{{ user.name }}</span>
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </template>
        <template v-else>
          <v-card-text>
            <p class="text-center text-h6">該当するユーザーはいませんでした</p>
          </v-card-text>
        </template>
      </v-card>
      <v-pagination
        v-model="page"
        :length="pageLength"
      />
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters, mapMutations } from 'vuex'
export default {
  data() {
    return {
      filterQuery: {
        name: ''
      },
      icon: require('@/assets/images/default.png'),
      page: 1,
      pageSize: 5
    }
  },
  async fetch({ $axios, store }) {
    await $axios
      .$get('/api/v1/users')
      .then((res) => {
        store.commit('user/usersSet', res)
      })
      .catch((e) => {
        console.log(e)
      })
  },
  head() {
    return {
      title: 'ユーザー検索'
    }
  },
  computed: {
    ...mapGetters('user', [
      'filteredUsers'
    ]),
    pageLength() {
      const length = Math.ceil(this.filteredUsers.length / this.pageSize)
      return length
    },
    viewLists() {
      const lists = this.filteredUsers.slice(
        this.pageSize * (this.page - 1),
        this.pageSize * this.page
      )
      return lists
    }
  },
  methods: {
    ...mapMutations('user', [
      'filterQuerySet'
    ]),
    handleChangeQuery() {
      this.page = 1
      this.filterQuerySet(this.filterQuery)
    },
    userShowClick(user) {
      this.$router.push(`/users/${user.id}`)
    }
  }
}
</script>
