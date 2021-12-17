<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="10" md="8">
      <v-data-iterator
        :items="filteredArchitectures"
        :items-per-page="itemsPerPage"
        no-results-text="該当する投稿はありません"
        :page="page"
        :search="search"
        :sort-by="sortBy.toLowerCase()"
        :sort-desc="sortDesc"
        hide-default-footer
      >
        <template #header>
          <v-toolbar
            dark
            color="light-blue lighten-2"
            class="mb-1"
          >
            <template v-if="$vuetify.breakpoint.mdAndUp">
              <v-text-field
                v-model="search"
                clearable
                flat
                solo-inverted
                hide-details
                prepend-inner-icon="mdi-magnify"
                label="検索"
              />
              <v-spacer />
              <v-autocomplete
                v-model="architecture"
                :items="architectures"
                flat
                hide-details
                solo-inverted
                no-data-text="該当する建築物はありません"
                item-text="name"
                item-value="id"
                clearable
                placeholder="建築物を選択"
              />
              <v-spacer />
              <v-btn-toggle
                v-model="sortDesc"
                mandatory
              >
                <v-btn
                  large
                  depressed
                  color="red lighten-1"
                  :value="false"
                >
                  <v-icon>mdi-arrow-up</v-icon>
                </v-btn>
                <v-btn
                  large
                  depressed
                  color="indigo darken-1"
                  :value="true"
                >
                  <v-icon>mdi-arrow-down</v-icon>
                </v-btn>
              </v-btn-toggle>
            </template>
          </v-toolbar>
        </template>
        <template #default="props">
          <v-row>
            <v-col
              v-for="item in props.items"
              :key="item.id"
              cols="12"
              sm="6"
              md="4"
              lg="4"
            >
              <v-card @click="postClick(item)">
                <v-img :src="item.image.url" />
                <v-card-title
                  class="justify-center font-weight-bold"
                >
                  <span class="text-truncate">{{ item.title }}</span>
                </v-card-title>
                <v-card-actions class="py-0">
                  <div class="d-inline-block" @click.stop="userClick(item.user)">
                    <v-avatar size="50">
                      <v-img :src="item.user.image.url" />
                    </v-avatar>
                    {{ item.user.name }}
                  </div>
                  <v-spacer />
                  <elapsed-time :content="item" />
                </v-card-actions>
                <v-card-actions class="justify-end pt-0">
                  <like-button :post="item" />
                </v-card-actions>
              </v-card>
            </v-col>
          </v-row>
        </template>
        <template  #footer>
          <v-row
            align="center"
            justify="center"
          >
            <span class="grey--text">Items per page</span>
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
            grey--text"
          >
            Page {{ page }} of {{ numberOfPages }}
          </span>
          <v-btn
            fab
            color="light-blue lighten-2"
            class="mr-1"
            @click="formerPage"
          >
            <v-icon>mdi-chevron-left</v-icon>
          </v-btn>
          <v-btn
            fab
            color="light-blue lighten-2"
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
import LikeButton from '~/components/like/LikeButton.vue'
import ElapsedTime from '~/components/time/ElapsedTime.vue'
export default {
  components: {
    LikeButton,
    ElapsedTime
  },
  async asyncData({ app }) {
    const [posts, architectures] = await Promise.all([
      app.$axios.$get('/api/v1/posts'),
      app.$axios.$get('/api/v1/architectures')
    ])
    return { posts, architectures }
  },
  data() {
    return {
      itemsPerPageArray: [6, 9, 12],
      search: '',
      sortDesc: false,
      page: 1,
      itemsPerPage: 6,
      sortBy: 'created_at',
      groupBy: 'architecture_id',
      posts: null,
      architectures: null,
      architecture: null
    }
  },
  head() {
    return {
      title: '投稿検索'
    }
  },
  computed: {
    ...mapGetters('post', [
      'post'
    ]),
    numberOfPages () {
      return Math.ceil(this.posts.length / this.itemsPerPage)
    },
    postUpdate() {
      return this.post
    },
    filteredArchitectures() {
      if (this.architecture !== null) {
        const list = []
        for (let i = 0; i < this.posts.length; i++) {
          const post = this.posts[i]
          if (post.architecture) {
            if (post.architecture.id === this.architecture) {
              list.push(post)
            }
          }
        }
        return list
      } else {
        return this.posts
      }
    }
  },
  watch: {
    postUpdate() {
      this.$axios
        .get('/api/v1/posts')
        .then((res) => {
          this.posts = res.data
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
    postClick(post) {
      this.$router.push(`/posts/${post.id}`)
    },
    userClick(user) {
      this.$router.push(`/users/${user.id}`)
    }
  }
}
</script>
