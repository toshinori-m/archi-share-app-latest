export const state = () => ({
  drawer: false
})

export const getters = {
  drawer: (state) => state.drawer
}

export const mutations = {
  drawerSet(state) {
    state.drawer = !state.drawer
  }
}
