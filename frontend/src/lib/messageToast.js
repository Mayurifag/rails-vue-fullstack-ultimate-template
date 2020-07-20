import Vue from 'vue'

export default {
  showMessage (message) {
    Vue.prototype.$message({
      showClose: true,
      message
    })
  },

  showSuccess (message) {
    Vue.prototype.$message({
      showClose: true,
      type: 'success',
      message
    })
  },

  showError (message) {
    Vue.prototype.$message({
      showClose: true,
      type: 'error',
      message
    })
  },

  showWarning (message) {
    Vue.prototype.$message({
      showClose: true,
      type: 'warning',
      message
    })
  }
}
