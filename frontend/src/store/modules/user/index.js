import * as actions from './actions'
import mutations from './mutations'
import { initialState } from './state'

const getters = {
  isAuthorized (state) {
    return state.signedIn
  },
  getCsrfToken (state) {
    return state.csrf
  },
  getEmail (state) {
    return state.currentUser.email
  }
}

export default {
  namespaced: true,
  state: initialState(),
  actions,
  mutations,
  getters
}
