import * as actions from './actions'
import mutations from './mutations'
import { initialState } from './state'

const getters = {
  getLanguage (state) {
    return state.language
  },
  getLanguagesArrayWithoutCurrent (state) {
    const array = ['en', 'ru']
    const index = array.indexOf(state.language)
    if (index > -1) {
      array.splice(index, 1)
    }
    return array
  }
}

export default {
  namespaced: true,
  state: initialState(),
  actions,
  mutations,
  getters
}
