<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="9" md="7">
      <v-card>
        <div class="d-flex justify-space-between pt-4">
          <v-avatar size="100" class="ma-4">
            <v-img v-if="user.image.url" :src="user.image.url" />
            <v-img v-else :src="icon" />
          </v-avatar>
          <user-follow-count :followings="user.followings" :followers="user.followers" />
          <user-follow-button
            :user="user"
            class="mr-4"
          />
        </div>
        <v-card-text class="pt-0 text--primary">
          <p class="text-h6">{{ user.name }}</p>
          <p>{{ user.introduction }}</p>
        </v-card-text>
        <v-card-actions v-if="user.id == currentUser.id" class="justify-end pa-4 pt-0">
          <v-btn outlined @click="userEditButton">
            ユーザー情報を編集
          </v-btn>
        </v-card-actions>
      </v-card>
    </v-col>
  </v-row>
</template>

<script>
import { mapGetters } from 'vuex'
import UserFollowButton from '~/components/user/UserFollowButton.vue'
import UserFollowCount from '~/components/user/UserFollowCount.vue'
export default {
  components: {
    UserFollowButton,
    UserFollowCount
  },
  data() {
    return {
      title: '',
      icon: require('@/assets/images/default.png')
    }
  },
  async fetch({ $axios, params, store }) {
    await $axios
      .$get(`/api/v1/users/${params.id}`)
      .then((res) => {
        store.commit('user/userSet', res)
      })
      .catch((e) => {
        console.log(e)
      })
  },
  head() {
    return {
      title: this.title
    }
  },
  computed: {
    ...mapGetters({
      currentUser: 'authentication/currentUser',
      user: 'user/user'
    })
  },
  created() {
    this.title = this.user.name
  },
  methods: {
    userEditButton() {
      this.$router.push('/users/edit')
    }
  }
}
</script>
