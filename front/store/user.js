export const state = () => ({
  user: null
})

export const getters = {
  user: (state) => state.user
}

export const mutations = {
  userSet(state, data) {
    state.user = data
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
