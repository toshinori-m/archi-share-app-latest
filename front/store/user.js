export const state = () => ({
  user: null,
  users: null,
  filterQuery: {
    name: ''
  }
})

export const getters = {
  user: (state) => state.user,
  filteredUsers(state) {
    let data = state.users
    if (state.filterQuery.name !== '') {
      data = data.filter(function(row) {
        return row.name.includes(state.filterQuery.name)
      })
    }
    return data
  }
}

export const mutations = {
  userSet(state, data) {
    state.user = data
  },
  usersSet(state, data) {
    state.users = data
  },
  filterQuerySet(state, filterQuery) {
    state.filterQuery = { ...filterQuery }
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
