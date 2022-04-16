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
  async signUp({ dispatch }, authData) {
    const response = await this.$axios
      .$post('/api/v1/auth', {
        name: authData.name,
        email: authData.email,
        password: authData.password,
        password_confirmation: authData.passwordConfirmation,
        introduction: 'よろしくお願いします'
      })
      .catch((e) => {
        console.log(e)
        dispatch(
          'snackbarMessage/messageShow',
          {
            message: 'このメールアドレスは既に使用されています',
            type: 'error',
            status: true
          },
          { root: true }
        )
      })
    return response
  },
  async signIn({ dispatch }, authData) {
    const response = await this.$axios
      .$post('/api/v1/auth/sign_in', authData)
      .catch((e) => {
        console.log(e)
        dispatch(
          'snackbarMessage/messageShow',
          {
            message: 'メールアドレスまたはパスワードが違います',
            type: 'error',
            status: true
          },
          { root: true }
        )
      })
    return response
  },
  async userSignUp({ dispatch }, authData) {
    dispatch('progressLinear/linearGet', true, { root: true })
    const res = await dispatch('signUp', authData)
    if (!res) {
      dispatch('progressLinear/linearGet', false, { root: true })
      return
    }
    dispatch('modal/userSignUpModal', false, { root: true })
    dispatch('currentUserInfo', res.data)
    dispatch('progressLinear/linearGet', false, { root: true })
    dispatch(
      'snackbarMessage/messageShow',
      {
        message: 'ユーザーを登録しました',
        type: 'success',
        status: true
      },
      { root: true }
    )
  },
  async userSignIn({ dispatch }, authData) {
    dispatch('progressLinear/linearGet', true, { root: true })
    const res = await dispatch('signIn', authData)
    if (!res) {
      dispatch('progressLinear/linearGet', false, { root: true })
      return
    }
    dispatch('modal/userSignInModal', false, { root: true })
    dispatch('currentUserInfo', res.data)
    dispatch('progressLinear/linearGet', false, { root: true })
    dispatch(
      'snackbarMessage/messageShow',
      {
        message: 'ログインに成功しました',
        type: 'success',
        status: true
      },
      { root: true }
    )
  },
  async signOut({ context }) {
    await this.$axios
      .$delete('/api/v1/auth/sign_out')
      .catch((e) => {
        console.log(e)
      })
  },
  async userSignOut({ commit, dispatch }) {
    await dispatch('signOut')
    commit('loginSet', false)
    commit('currentUserSet', null)
    dispatch(
      'snackbarMessage/messageShow',
      {
        message: 'ログアウトしました',
        type: 'success',
        status: true
      },
      { root: true }
    )
  }
}
