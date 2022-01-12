<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="10" md="10">
      <template v-if="$vuetify.breakpoint.smAndUp">
        <v-toolbar
          dark
          color="primary"
          class="mb-1"
        >
          <v-row justify="center" align="center">
            <v-col cols="12" sm="4" md="5">
              <v-text-field
                v-model="search"
                clearable
                flat
                solo-inverted
                hide-details
                prepend-inner-icon="mdi-magnify"
                label="検索"
              />
            </v-col>
            <v-col cols="8" sm="4" md="5">
              <v-combobox
                v-model="selectedItem"
                :items="architectures"
                item-text="name"
                item-value="id"
                flat
                hide-details
                solo-inverted
                no-data-text="該当する建築物はありません"
                clearable
                label="建築物を選択"
              />
            </v-col>
            <v-col cols="4" sm="4" md="2">
              <div class="text-center">
                <v-btn
                  v-if="sort"
                  large
                  color="error"
                  @click="descent">
                  昇順
                </v-btn>
                <v-btn
                  v-else
                  large
                  color="blue"
                  @click="ascent"
                >
                  降順
                </v-btn>
              </div>
            </v-col>
          </v-row>
        </v-toolbar>
      </template>
      <template v-else>
        <v-toolbar
          dark
          flat
          color="primary"
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
        <v-toolbar dark flat color="primary" class="mb-1">
          <v-combobox
            v-model="selectedItem"
            :items="architectures"
            item-text="name"
            item-value="id"
            flat
            hide-details
            solo-inverted
            no-data-text="該当する建築物はありません"
            clearable
            label="建築物を選択"
          />
          <v-btn
            v-if="sort"
            large
            color="error"
            class="ml-2"
            @click="descent">
            昇順
          </v-btn>
          <v-btn
            v-else
            large
            color="blue"
            class="ml-2"
            @click="ascent"
          >
            降順
          </v-btn>
        </v-toolbar>
      </template>
      <v-row v-if="viewLists">
        <v-col
          v-for="item in viewLists"
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
              <div class="d-inline-block text-truncate" @click.stop="userClick(item.user)">
                <v-avatar size="50">
                  <v-img :src="item.user.image.url" />
                </v-avatar>
                <span class="">{{ item.user.name }}</span>
              </div>
              <v-spacer />
            </v-card-actions>
            <v-card-actions class="justify-end pt-0">
              <v-spacer />
              <like-button :post="item" />
              <v-spacer />
              <elapsed-time :content="item" />
            </v-card-actions>
          </v-card>
        </v-col>
      </v-row>
      <v-row>
        <v-col cols="12">
          <v-card v-if="!viewLists[0]">
            <v-card-text class="text-center">
              <span class="text-h6">
                該当する建築物はありません
              </span>
            </v-card-text>
          </v-card>
        </v-col>
      </v-row>
      <div>
        <v-row
          class="ma-2"
          align="center"
          justify="center"
        >
          <v-spacer />
          <span class="mr-4 primary--text">
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
      </div>
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
  filters: {
    filteredName(name) {
      return name.length > 10 ? name.slice(0, 9) + '...' : name
    }
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
      posts: null,
      architectures: null,
      search: '',
      sort: false,
      selectedItem: null,
      itemsPerPage: 6,
      page: 1
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
    filteredSearch() {
      if (this.search) {
        const list = []
        for (let i = 0; i < this.posts.length; i++) {
          const post = this.posts[i]
          if (post.title.includes(this.search)) {
            list.push(post)
          }
        }
        return list
      } else {
        return this.posts
      }
    },
    filteredArchi() {
      if (this.selectedItem) {
        const data = this.filteredSearch
        const list = []
        for (let i = 0; i < data.length; i++) {
          const post = data[i]
          if (post.architecture && post.architecture.id === this.selectedItem.id) {
            list.push(post)
          }
        }
        return list
      } else {
        return this.filteredSearch
      }
    },
    viewLists() {
      const lists = this.filteredArchi.slice(
        this.itemsPerPage * (this.page - 1),
        this.itemsPerPage * this.page
      )
      return lists
    },
    numberOfPages() {
      return Math.ceil(this.filteredArchi.length / this.itemsPerPage)
    },
    postUpdate() {
      return this.post
    },
    pageCheck() {
      return this.selectedItem
    }
  },
  watch: {
    postUpdate() {
      const data = this.posts.findIndex(n => n.id === this.post.id )
      this.posts.splice(data, 1, this.post)
    },
    pageCheck() {
      this.page = 1
    }
  },
  methods: {
    nextPage() {
      if (this.page + 1 <= this.numberOfPages) this.page += 1
    },
    formerPage() {
      if (this.page - 1 >= 1) this.page -= 1
    },
    postClick(post) {
      this.$router.push(`/posts/${post.id}`)
    },
    userClick(user) {
      this.$router.push(`/users/${user.id}`)
    },
    descent() {
      this.posts.reverse()
      this.sort = false
    },
    ascent() {
      this.posts.reverse()
      this.sort = true
    }
  }
}
</script>
