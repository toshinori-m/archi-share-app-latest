<template>
  <v-row justify="center" justify-lg="start" algin="center">
    <template v-if="$vuetify.breakpoint.lgAndUp">
      <v-col lg="5">
        <v-card>
          <v-toolbar
            flat
            color="tertiary"
            class="primary--text mb-1"
          >
            最近登録したユーザー
          </v-toolbar>
          <v-list>
            <v-list-item
              v-for="user in recentUsers"
              :key="user.id"
              @click="userClick(user)"
            >
              <v-list-item-avatar size="40">
                <v-img v-if="user.image.url" :src="user.image.url" />
                <v-img v-else :src="icon" />
              </v-list-item-avatar>
              <v-list-item-content>
                <span class="text-body2">{{ user.name }}</span>
              </v-list-item-content>
              <v-list-item-action>
                <user-follow-button :user="user" />
              </v-list-item-action>
            </v-list-item>
          </v-list>
        </v-card>
      </v-col>
    </template>
    <v-col cols="12" sm="10" md="8" lg="7">
      <v-data-iterator
        :items="users"
        :items-per-page="itemsPerPage"
        no-results-text="該当するはありません"
        :page="page"
        :search="search"
        hide-default-footer
      >
        <template #header>
          <v-toolbar
            dark
            color="primary"
            class="mb-1"
          >
            <v-text-field
              v-model="search"
              clearable
              flat
              solo-inverted
              hide-details
              prepend-inner-icon="mdi-magnify"
              label="検索"
            />
          </v-toolbar>
        </template>
        <template #default="props">
          <v-card>
            <v-list>
              <v-list-item
                v-for="item in props.items"
                :key="item.id"
                @click="userClick(item)"
              >
                <v-list-item-avatar v-if="$vuetify.breakpoint.smAndUp" size="60">
                  <v-img v-if="item.image.url" :src="item.image.url" />
                  <v-img v-else :src="icon" />
                </v-list-item-avatar>
                <v-list-item-avatar v-else size="40">
                  <v-img v-if="item.image.url" :src="item.image.url" />
                  <v-img v-else :src="icon" />
                </v-list-item-avatar>
                <v-list-item-content>
                  <span
                    v-if="$vuetify.breakpoint.smAndUp"
                    class="text-caption text-sm-h6"
                  >
                    {{ item.name }}
                  </span>
                  <span
                    v-else
                    class="text-caption text-sm-h6"
                  >
                    {{ item.name | filteredName }}
                  </span>
                </v-list-item-content>
                <v-list-item-action>
                  <user-follow-button :user="item" />
                  <admin-user-delete-modal
                    v-if="login && currentUser.admin"
                    :user="item" @load="loadUsers"
                  />
                </v-list-item-action>
              </v-list-item>
            </v-list>
          </v-card>
        </template>
        <template #footer>
          <v-row
            align="center"
            justify="center"
            class="ma-2"
          >
            <span class="primary--text">Items per page</span>
            <v-menu offset-y>
              <template #activator="{ on, attrs }">
                <v-btn
                  dark
                  text
                  color="primary"
                  class="ml-2"
                  v-bind="attrs"
                  v-on="on"
                >
                  {{ itemsPerPage }}
                  <v-icon>mdi-chevron-down</v-icon>
                </v-btn>
              </template>
              <v-list>
                <v-list-item
                  v-for="(number, index) in itemsPerPageArray"
                  :key="index"
                  @click="updateItemsPerPage(number)"
                >
                  <v-list-item-title>{{ number }}</v-list-item-title>
                </v-list-item>
              </v-list>
            </v-menu>
            <v-spacer />
            <span
              class="mr-4
              primary--text"
            >
              Page {{ page }} of {{ numberOfPages }}
            </span>
            <v-btn
              fab
              color="secondary"
              class="mr-1"
              @click="formerPage"
            >
              <v-icon>mdi-chevron-left</v-icon>
            </v-btn>
            <v-btn
              fab
              color="secondary"
              class="ml-1"
              @click="nextPage"
            >
              <v-icon>mdi-chevron-right</v-icon>
            </v-btn>
          </v-row>
        </template>
      </v-data-iterator>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters } from 'vuex'
import UserFollowButton from '~/components/user/UserFollowButton.vue'
import AdminUserDeleteModal from '~/components/admin/AdminUserDeleteModal.vue'
export default {
  components: {
    UserFollowButton,
    AdminUserDeleteModal
  },
  filters: {
    filteredName(name) {
      return name.length > 9 ? name.slice(0, 8) + '...' : name
    }
  },
  async asyncData({ $axios }) {
    const users = await $axios
      .$get('/api/v1/users')
    return { users }
  },
  data() {
    return {
      users: null,
      icon: require('@/assets/images/default.png'),
      itemsPerPageArray: [6, 12, 18],
      search: '',
      page: 1,
      itemsPerPage: 6,
    }
  },
  head() {
    return {
      title: 'ユーザー検索'
    }
  },
  computed: {
    ...mapGetters('authentication', [
      'currentUser',
      'login'
    ]),
    numberOfPages () {
      return Math.ceil(this.users.length / this.itemsPerPage)
    },
    recentUsers() {
      const data = this.users.slice(-5).reverse()
      return data
    },
    currentUserCheck() {
      return this.currentUser
    }
  },
  watch: {
    currentUserCheck() {
      this.$axios
        .get('api/v1/users')
        .then((res) => {
          this.users = res.data
        })
        .catch((e) => {
          console.log(e)
        })
    }
  },
  methods: {
    nextPage () {
      if (this.page + 1 <= this.numberOfPages) this.page += 1
    },
    formerPage () {
      if (this.page - 1 >= 1) this.page -= 1
    },
    updateItemsPerPage (number) {
      this.itemsPerPage = number
    },
    userClick(user) {
      this.$router.push(`/users/${user.id}`)
    },
    async loadUsers() {
      await this.$axios
        .get('api/v1/users')
        .then((res) => {
          this.users = res.data
        })
        .catch((e) => {
          console.log(e)
        })
    }
  }
}
</script>
