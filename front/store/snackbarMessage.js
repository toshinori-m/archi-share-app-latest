export const state = () => ({
  message: '',
  type: '',
  status: false
})

export const getters = {
  message: (state) => state.message,
  type: (state) => state.type,
  status: (state) => state.status
}

export const mutations = {
  messageSet(state, message) {
    state.message = message
  },
  typeSet(state, type) {
    state.type = type
  },
  statusSet(state, bool) {
    state.status = bool
  }
}

export const actions = {
  messageShow({ commit }, { message, type, status }) {
    commit('messageSet', message)
    commit('typeSet', type)
    commit('statusSet', status)
    setTimeout(() => {
      commit('statusSet', !status)
    }, 2000)
  }
}
