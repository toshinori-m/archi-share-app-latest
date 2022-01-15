export const state = () => ({
  user: null,
  userPost: null,
  userLikePost: null
})

export const getters = {
  user: (state) => state.user,
  userPost: (state) => state.userPost,
  userLikePost: (state) => state.userLikePost
}

export const mutations = {
  userSet(state, data) {
    state.user = data
  },
  userPostSet(state, data) {
    state.userPost = data
  },
  userLikePostSet(state, data) {
    state.userLikePost = data
  },
  userPostUpdate(state, data) {
    const index = state.userPost.findIndex(n => n.id === data.id )
    state.userPost.splice(index, 1, data)
  },
  userLikePostUpdate(state, data) {
    const index = state.userLikePost.findIndex(n => n.id === data.id )
    state.userLikePost.splice(index, 1, data)
  }
}

export const actions = {
  async userGet({ commit }, paramsId) {
    const response = await this.$axios
      .$get(`/api/v1/users/${paramsId}`)
      .catch((error) => {
        console.log(error)
      })
    commit('userSet', response)
  }
}
