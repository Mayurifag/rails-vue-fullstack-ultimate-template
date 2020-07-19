import Vue from 'vue'
import App from './App'
import '@plugins/registerServiceWorker'
import router from '@router'
import { store } from '@store'
import '@plugins/element.js'
import i18n from '@plugins/i18n'

Vue.config.productionTip = false

new Vue({
  el: '#app',
  router,
  store,
  i18n,
  render: h => h(App)
}).$mount('#app')
