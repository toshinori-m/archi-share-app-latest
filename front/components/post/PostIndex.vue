<template>
  <v-data-iterator
    :items="posts"
    no-data-text="表示する投稿がありません"
    :items-per-page="itemsPerPage"
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
              <comment-count :comments="item.comments" />
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
import CommentCount from '~/components/comment/CommentCount.vue'
import ElapsedTime from '~/components/time/ElapsedTime.vue'
export default {
  components: {
    LikeButton,
    CommentCount,
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
      page: 1,
      itemsPerPage: 9,
      icon: require('@/assets/images/default.png')
    }
  },
  computed: {
    numberOfPages () {
      if (this.posts.length) {
        return Math.ceil(this.posts.length / this.itemsPerPage)
      } else {
        return 1
      }
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
    }
  }
}
</script>
