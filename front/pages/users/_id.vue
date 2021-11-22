<template>
  <v-row justify="center" align="center">
    <v-col cols="12" sm="9" md="7">
      <v-card>
        <v-avatar size="100" class="ma-4">
          <v-img v-if="user.image.url" :src="user.image.url" />
          <v-img v-else :src="icon" />
        </v-avatar>
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
export default {
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
  data() {
    return {
      title: '',
      icon: require('@/assets/images/default.png')
    }
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
