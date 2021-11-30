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
  }
}

export const actions = {
  async postGet({ commit }, paramsId) {
    const response = await this.$axios
      .$get(`/api/v1/posts/${paramsId}`)
      .catch((error) => {
        console.log(error)
      })
    commit('postSet', response)
  }
}
