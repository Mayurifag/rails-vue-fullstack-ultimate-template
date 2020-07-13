import Vue from 'vue'
import App from './App'
import '@lib/registerServiceWorker'
import router from '@router'
import { store } from '@store'
import '@plugins/element.js'

Vue.config.productionTip = false

new Vue({
  el: '#app',
  router,
  store,
  render: h => h(App)
}).$mount('#app')
