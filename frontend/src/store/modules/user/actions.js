// import Vue from 'vue'
import messageToast from '@lib/messageToast'
import * as types from './mutation_types'

export const unsetCurrentUser = ({ commit }, { errorMessage }) => {
  commit(types.UNSET_CURRENT_USER)
  if (typeof (errorMessage) !== 'undefined') {
    messageToast.showError(errorMessage)
  }
}

export const setCurrentUser = ({ commit }, { currentUser, csrf }) => {
  commit(types.SET_CURRENT_USER, { currentUser: currentUser, csrf: csrf })
}
