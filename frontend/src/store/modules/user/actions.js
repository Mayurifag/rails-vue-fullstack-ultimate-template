import messageToast from '@lib/messageToast'

export const unsetCurrentUser = ({ commit }, { errorMessage }) => {
  commit('UNSET_CURRENT_USER')
  if (typeof (errorMessage) !== 'undefined') {
    messageToast.showError(errorMessage)
  }
}

export const setCurrentUser = ({ commit }, { currentUser, csrf }) => {
  commit('SET_CURRENT_USER', { currentUser: currentUser, csrf: csrf })
}
