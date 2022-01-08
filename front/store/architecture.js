export const state = () => ({
  architecture: null,
  architectures: null,
  filterQuery: {}
})

export const getters = {
  architecture: (state) => state.architecture,
  architectures: (state) => state.architectures,
  filteredArchitectures(state) {
    let data = state.architectures
    if (state.filterQuery.prefecture) {
      data = data.filter(function(row) {
        if (row.prefecture) {
          return row.prefecture.includes(state.filterQuery.prefecture)
        } else {
          return false
        }
      })
    }
    if (state.filterQuery.construction && state.filterQuery.construction[0]) {
      const construct = state.filterQuery.construction
      data = data.filter(function(row) {
        for (let i = 0; i < construct.length; i++) {
          if (!row.construction.includes(construct[i])) {
            return false
          }
        }
        return true
      })
    }
    if (state.filterQuery.designer) {
      data = data.filter(function(row) {
        if (row.designer !== null) {
          return row.designer.includes(state.filterQuery.designer)
        } else {
          return false
        }
      })
    }
    if (state.filterQuery.aboveFloor) {
      data = data.filter(function(row) {
        if (row.above_floor) {
          return row.above_floor.includes(state.filterQuery.aboveFloor)
        } else {
          return false
        }
      })
    }
    if (state.filterQuery.underFloor) {
      data = data.filter(function(row) {
        if (row.under_floor) {
          return row.under_floor.includes(state.filterQuery.underFloor)
        } else {
          return false
        }
      })
    }
    return data
  }
}

export const mutations = {
  archiSet(state, archi) {
    state.architecture = archi
  },
  architecturesSet(state, archi) {
    state.architectures = archi
  },
  filterQuerySet(state, filterQuery) {
    state.filterQuery = { ...filterQuery }
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
  }
}
