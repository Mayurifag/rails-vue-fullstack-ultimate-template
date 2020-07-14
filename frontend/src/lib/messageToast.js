import Vue from 'vue'
// import { Message } from 'element-ui'

// Vue.use(Message)

export default {
  showMessage (message) {
    Vue.prototype.$message({
      showClose: true,
      duration: 1000,
      message
    })
  },

  showSuccess (message) {
    Vue.prototype.$message({
      showClose: true,
      type: 'success',
      duration: 500,
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
