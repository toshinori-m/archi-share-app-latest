<template>
  <div class="d-flex justify-center">
    <template v-if="$vuetify.breakpoint.mdAndUp">
      <v-btn
        large
        text
        color="primary"
        @click="dialog1 = true"
      >
        フォロー<br />
        {{ followings.length }}
      </v-btn>
      <v-btn
        large
        text
        color="primary"
        @click="dialog2 = true"
      >
        フォロワー<br />
        {{ followers.length }}
      </v-btn>
    </template>
    <template v-if="$vuetify.breakpoint.smOnly">
      <v-btn
        small
        text
        color="primary"
        @click="dialog1 = true"
      >
        フォロー<br />
        {{ followings.length }}
      </v-btn>
      <v-btn
        small
        text
        color="primary"
        @click="dialog2 = true"
      >
        フォロワー<br />
        {{ followers.length }}
      </v-btn>
    </template>
    <template v-if="$vuetify.breakpoint.xsOnly">
      <v-btn
        x-small
        text
        color="primary"
        @click="dialog1 = true"
      >
        フォロー<br />
        {{ followings.length }}
      </v-btn>
      <v-btn
        x-small
        text
        color="primary"
        @click="dialog2 = true"
      >
        フォロワー<br />
        {{ followers.length }}
      </v-btn>
    </template>
    <template v-if="dialog1">
      <v-dialog
        v-if="$vuetify.breakpoint.xsOnly"
        v-model="dialog1"
        fullscreen
        hide-overlay
        transition="dialog-bottom-transition"
      >
        <user-follow-list
          :followings="followings"
          :followers="followers"
          :tabs="false"
          @close="dialog1 = false"
        />
      </v-dialog>
      <v-dialog
        v-else
        v-model="dialog1"
        persistent
        width="500"
      >
        <user-follow-list
          :followings="followings"
          :followers="followers"
          :tabs="false"
          @close="dialog1 = false"
        />
      </v-dialog>
    </template>
    <template v-if="dialog2">
      <v-dialog
        v-if="$vuetify.breakpoint.xsOnly"
        v-model="dialog2"
        fullscreen
        hide-overlay
        transition="dialog-bottom-transition"
      >
        <user-follow-list
          :followings="followings"
          :followers="followers"
          :tabs="true"
          @close="dialog2 = false"
        />
      </v-dialog>
      <v-dialog
        v-else
        v-model="dialog2"
        persistent
        width="500"
      >
        <user-follow-list
          :followings="followings"
          :followers="followers"
          :tabs="true"
          @close="dialog2 = false"
        />
      </v-dialog>
    </template>
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
