<template>
  <div>
    <div
      v-for="comment in comments"
      :key="comment.id"
    >
      <v-card-actions>
        <div
          class="link"
          @click="userClick(comment.user)"
        >
          <v-avatar size="40" class="ma-2">
            <v-img
              v-if="comment.user.image.url"
              :src="comment.user.image.url"
            />
            <v-img v-else :src="icon" />
          </v-avatar>
          <span>{{ comment.user.name }}</span>
        </div>
        <v-spacer />
        <comment-setting-button v-if="login" :comment="comment" />
      </v-card-actions>
      <p class="px-5">{{ comment.content }}</p>
      <v-divider />
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import CommentSettingButton  from '~/components/comment/CommentSettingButton.vue'
export default {
  components: {
    CommentSettingButton
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
      'login'
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
