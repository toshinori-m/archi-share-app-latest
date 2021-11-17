export const state = () => ({
  currentUser: null,
  login: false
})

export const getters = {
  currentUser: (state) => state.currentUser,
  login: (state) => state.login
}

export const mutations = {
  currentUserSet(state, payload) {
    state.currentUser = payload
  },
  loginSet(state, bool) {
    state.login = bool
  }
}

export const actions = {
  async currentUserInfo({ commit }, payload) {
    await this.$axios
      .$get(`/api/v1/users/${payload.id}`)
      .then((res) => {
        commit('currentUserSet', res)
        commit('loginSet', true)
      })
      .catch((e) => {
        console.log(e)
      })
  },
  async signUp({ context }, authData) {
    const response = await this.$axios
      .$post('/api/v1/auth', authData)
      .catch((e) => [
        console.log(e)
      ])
    return response
  },
  async signIn({ context }, authData) {
    const response = await this.$axios
      .$post('/api/v1/auth/sign_in', authData)
      .catch((e) => {
        console.log(e)
      })
    return response
  },
  async userSignUp({ dispatch }, authData) {
    const res = await dispatch('signUp', authData)
    if (!res) {
      return
    }
    dispatch('currentUserInfo', res.data)
  },
  async userSignIn({ dispatch }, authData) {
    const res = await dispatch('signIn', authData)
    if (!res) {
      return
    }
    dispatch('currentUserInfo', res.data)
  },
  async signOut({ context }) {
    const response = await this.$axios
      .$delete('/api/v1/auth/sign_out')
      .catch((e) => {
        console.log(e)
      })
    return response
  },
  async userSignOut({ commit, dispatch }) {
    const res = await dispatch('signOut')
    if (!res) {
      return
    }
    commit('loginSet', false)
    commit('currentUserSet', null)
  }
}
