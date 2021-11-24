<template>
  <div class="d-flex">
    <v-btn large text @click="dialog1 = true">
      フォロー<br />
      {{ followings.length }}
    </v-btn>
    <v-btn large text @click="dialog2 = true">
      フォロワー<br />
      {{ followers.length }}
    </v-btn>
    <v-dialog v-model="dialog1" width="500">
      <user-follow-list
        :followings="followings"
        :followers="followers"
        :tabs="false"
        @close="dialog1 = false"
      />
    </v-dialog>
    <v-dialog v-model="dialog2" width="500">
      <user-follow-list
        :followings="followings"
        :followers="followers"
        :tabs="true"
        @close="dialog2 = false"
      />
    </v-dialog>
  </div>
</template>

<script>
import UserFollowList from '~/components/user/UserFollowList.vue'
export default {
  components: {
    UserFollowList
  },
  props: {
    followings: {
      type: Array,
      required: true
    },
    followers: {
      type: Array,
      required: true
    }
  },
  data() {
    return {
      dialog1: false,
      dialog2: false
    }
  }
}
</script>
