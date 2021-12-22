<template>
  <div>
    <div
      v-for="(comment, i) in comments"
      :key="comment.id"
    >
      <v-row dense justify="center" align="center">
        <v-col cols="7" sm="8">
          <div
            class="link text-truncate"
            @click="userClick(comment.user)"
          >
            <v-avatar size="40" class="ma-2">
              <v-img
                v-if="comment.user.image.url"
                :src="comment.user.image.url"
              />
              <v-img v-else :src="icon" />
            </v-avatar>
            <span class="text-caption text-sm-subtitle-1">
              {{ comment.user.name }}
            </span>
          </div>
        </v-col>
        <v-col cols="5" sm="4">
          <v-card-actions
            class="justify-end"
            :class="currentUser.id !== comment.user.id ? 'pr-13' : ''"
          >
            <elapsed-time :content="comment" />
            <template v-if="login">
              <comment-setting-button
                v-if="currentUser.id == comment.user.id"
                :comment="comment"
              />
            </template>
          </v-card-actions>
        </v-col>
      </v-row>
      <p
        class="px-3"
        :class="(i === comments.length - 1) ? 'pb-4' : ''"
      >
        {{ comment.content }}
      </p>
      <v-divider v-if="i !== comments.length - 1" />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import CommentSettingButton  from '~/components/comment/CommentSettingButton.vue'
import ElapsedTime from '~/components/time/ElapsedTime.vue'
export default {
  components: {
    CommentSettingButton,
    ElapsedTime
  },
  props: {
    comments: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      icon: require('@/assets/images/default.png')
    }
  },
  computed: {
    ...mapGetters('authentication', [
      'login',
      'currentUser'
    ])
  },
  methods: {
    userClick(user) {
      this.$router.push(`/users/${user.id}`)
    }
  }
}
</script>

<style scoped>
.link {
  cursor: pointer;
}
</style>
