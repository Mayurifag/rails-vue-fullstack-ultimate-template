<template lang="pug">
  .auth-card
    el-card
      h2.mb-1em Sign in
      el-form(ref="form" label-width="6em" @submit.native.prevent="signin")
        el-form-item(prop="email" label="Email")
          el-input(v-model="email" placeholder="Enter your email")
        el-form-item(prop="password" label="Password")
          el-input(v-model="password" placeholder="Enter your password")
        el-form-item(label-width="0")
          el-button(type="primary" native-type="submit" block) Login
      router-link(to="/forgot_password") Forgot Password?
      router-link(to="/signup" class="display-block mt-1em") Sign Up
</template>

<script>
// TODO: валидации props для формочки
// TODO: поле пароля кастомное + скрыть значения и тд
import usersApi from '@api/users'
import { mapActions, mapGetters } from 'vuex'

export default {
  data () {
    return {
      email: '',
      password: ''
    }
  },
  created () {
    this.redirectToDashboardIfSignedIn()
  },
  updated () {
    this.redirectToDashboardIfSignedIn()
  },
  computed: {
    ...mapGetters('user', ['isAuthorized'])
  },
  methods: {
    ...mapActions('user', ['unsetCurrentUser', 'setCurrentUser']),
    signin () {
      usersApi.signIn(this.email, this.password)
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        return (this.signinFailed(response))
      }
      usersApi.whoami()
        .then(whoamiResponse => {
          this.setCurrentUser({ currentUser: whoamiResponse.data, csrf: response.data.csrf })
          this.$router.replace('/about_user')
        })
        .catch(error => this.signinFailed(error))
    },
    signinFailed (error) {
      const errorMessage = error.response && error.response.data && error.response.data.error
      this.unsetCurrentUser({ errorMessage: errorMessage })
    },
    redirectToDashboardIfSignedIn () {
      if (this.isAuthorized) {
        this.$router.replace('/about_user')
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@assets/shared_auth_styles'
</style>
