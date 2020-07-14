import * as actions from './actions'
import mutations from './mutations'
import getters from './getters'
import { initialState } from './state'

export default {
  namespaced: true,
  state: initialState(),
  actions,
  mutations,
  getters
}
