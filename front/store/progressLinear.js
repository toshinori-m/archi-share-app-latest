export const state = () => ({
  linear: false
})

export const getters = {
  linear: (state) => state.linear
}

export const mutations = {
  linearSet(state, bool) {
    state.linear = bool
  }
}

export const actions = {
  async linearGet({ commit }, bool) {
    await commit('linearSet', bool)
  }
}
