export const state = () => ({
  architecture: null
})

export const getters = {
  architecture: (state) => state.architecture
}

export const mutations = {
  archiSet(state, archi) {
    state.architecture = archi
  }
}

export const actions = {
  async archiGet({ commit }, archi) {
    const response = await this.$axios
      .$get(`/api/v1/architectures/${archi.id}`)
      .catch((e) => {
        console.log(e)
      })
    commit('archiSet', response)
  },
  async architecturesGet({ commit }) {
    const response = await this.$axios
      .$get('/api/v1/architectures')
      .catch((e) => {
        console.log(e)
      })
    commit('architecturesGet', response)
  }
}
