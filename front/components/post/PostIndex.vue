<template>
  <v-data-iterator
    :items="posts"
    :items-per-page="itemsPerPage"
    no-data-text="表示する投稿がありません"
    :page="page"
    hide-default-footer
  >
    <template #header>
      <v-toolbar
        class="mb-2"
        color="tertiary"
      >
        <v-toolbar-title class="primary--text">
          {{ toolTitle }}
        </v-toolbar-title>
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
            <v-img :src="item.image.url" height="250" />
            <v-card-title class="justify-center font-weight-bold">
              <span class="text-truncate">
                {{ item.title }}
              </span>
            </v-card-title>
            <v-card-actions class="py-0">
              <div
                class="d-inline-block text-truncate"
                @click.stop="userClick(item.user)"
              >
                <v-avatar size="50">
                  <v-img v-if="item.user.image.url" :src="item.user.image.url" />
                  <v-img v-else :src="icon" />
                </v-avatar>
                {{ item.user.name }}
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
    </template>
    <template #footer>
      <v-row
        class="ma-2"
        align="center"
        justify="center"
      >
        <span class="primary--text">
          Items per page
        </span>
        <v-menu offset-y>
          <template #activator="{ on, attrs }">
            <v-btn
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
              v-for="(number, i) in itemsPerPageArray"
              :key="i"
              @click="updateItemsPerPage(number)"
            >
              <v-list-item-title>
                {{ number }}
              </v-list-item-title>
            </v-list-item>
          </v-list>
        </v-menu>
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
    </template>
  </v-data-iterator>
</template>

<script>
import LikeButton from '~/components/like/LikeButton.vue'
import ElapsedTime from '~/components/time/ElapsedTime.vue'
export default {
  components: {
    LikeButton,
    ElapsedTime
  },
  props: {
    posts: {
      type: Array,
      required: true
    },
    toolTitle: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      itemsPerPageArray: [6, 9, 12],
      page: 1,
      itemsPerPage: 6,
      icon: require('@/assets/images/default.png')
    }
  },
  computed: {
    numberOfPages () {
      return Math.ceil(this.posts.length / this.itemsPerPage)
    },
    filteredKeys () {
      return this.keys.filter(key => key !== 'Name')
    }
  },
  methods: {
    postClick(post) {
      this.$router.push(`/posts/${post.id}`)
    },
    userClick(user) {
      this.$router.push(`/users/${user.id}`)
    },
    nextPage () {
      if (this.page + 1 <= this.numberOfPages) this.page += 1
    },
    formerPage () {
      if (this.page - 1 >= 1) this.page -= 1
    },
    updateItemsPerPage (number) {
      this.itemsPerPage = number
    }
  }
}
</script>
