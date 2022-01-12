export const state = () => ({
  post: null,
  posts: null
})

export const getters = {
  post: (state) => state.post,
  posts: (state) => state.posts
}

export const mutations = {
  postSet(state, data) {
    state.post = data
  },
  postsSet(state, data) {
    state.posts = data
  },
  postsUpdate(state, data) {
    const index = state.posts.findIndex(n => n.id === data.id )
    state.posts.splice(index, 1, data)
  }
}

export const actions = {
  async postGet({ commit }, paramsId) {
    const response = await this.$axios
      .$get(`/api/v1/posts/${paramsId}`)
      .catch((e) => {
        console.log(e)
      })
    commit('postSet', response)
  },
  async postsGet({ commit }) {
    const response = await this.$axios
      .$get('/api/v1/posts')
      .catch((e) => {
        console.log(e)
      })
    commit('postsSet', response)
  }
}
