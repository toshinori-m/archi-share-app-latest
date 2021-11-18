export const state = () => ({
  signUpModal: false,
  signInModal: false
})

export const getters = {
  signUpModal: (state) => state.signUpModal,
  signInModal: (state) => state.signInModal
}

export const mutations = {
  signUpModalClick(state, bool) {
    state.signUpModal = bool
  },
  signInModalClick(state, bool) {
    state.signInModal = bool
  }
}

export const actions = {
  async userSignUpModal({ commit }, bool) {
    await commit('signUpModalClick', bool)
  },
  async userSignInModal({ commit }, bool) {
    await commit('signInModalClick', bool)
  }
}
