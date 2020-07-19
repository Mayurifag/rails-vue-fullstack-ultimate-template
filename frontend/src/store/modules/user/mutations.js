export default {
  SET_CURRENT_USER: (state, { currentUser, csrf }) => {
    state.currentUser = currentUser
    state.signedIn = true
    state.csrf = csrf
  },
  UNSET_CURRENT_USER: (state) => {
    state.currentUser = {}
    state.signedIn = false
    state.csrf = null
  }
}
