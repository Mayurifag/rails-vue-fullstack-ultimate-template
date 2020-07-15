import * as actions from './actions'
import mutations from './mutations'
import { initialState } from './state'

const getters = {
  isAuthorized (state) {
    return state.signedIn
  },
  getCsrfToken (state) {
    return state.csrf
  }
}

export default {
  namespaced: true,
  state: initialState(),
  actions,
  mutations,
  getters
}
