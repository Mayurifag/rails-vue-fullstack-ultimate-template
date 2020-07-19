import Vue from 'vue'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
// TODO: import this for dark theme consult about that :S
// import 'element-theme-dark'

// If you dont import that, than you gonna have font issues
import 'element-ui/lib/theme-chalk/reset.css'

import lang from 'element-ui/lib/locale/lang/en'
import locale from 'element-ui/lib/locale'

locale.use(lang)

// TODO: element ui only needed things from package
Vue.use(ElementUI)

// TODO: element ui with i18n
