import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'SignIn',
      component: () => import(/* webpackChunkName: "signIn" */ '@views/users/SignIn.vue')
    },
    {
      path: '/signup',
      name: 'SignUp',
      component: () => import(/* webpackChunkName: "signUp" */ '@views/users/SignUp.vue')
    },
    {
      path: '/forgot_password',
      name: 'ForgotPassword',
      component: () => import(/* webpackChunkName: "ForgotPassword" */ '@views/users/ForgotPassword.vue')
    },
    {
      path: '/password_resets/:token',
      name: 'ResetPassword',
      component: () => import(/* webpackChunkName: "ResetPassword" */ '@views/users/ResetPassword.vue')
    },
    {
      path: '/about_user',
      name: 'AboutUser',
      component: () => import(/* webpackChunkName: "AboutUser" */ '@views/users/AboutUser.vue')
    }
  ],
  mode: 'history'
})
