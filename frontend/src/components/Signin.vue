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
// TODO: сделать отображение ошибок toast'ом или около того
// TODO: валидации props для формочки
// TODO: поле пароля кастомное + скрыть значения и тд
export default {
  data () {
    return {
      email: '',
      password: '',
      error: ''
    }
  },
  created () {
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  methods: {
    signin () {
      this.$http.plain.post('/api/users/signin', { email: this.email, password: this.password })
        .then(response => this.signinSuccessful(response))
        .catch(error => this.signinFailed(error))
    },
    signinSuccessful (response) {
      if (!response.data.csrf) {
        this.signinFailed(response)
        return
      }
      this.$http.plain.get('/api/users/whoami')
        .then(meResponse => {
          this.$store.commit('setCurrentUser', { currentUser: meResponse.data, csrf: response.data.csrf })
          this.error = ''
          this.$router.replace('/about_user')
        })
        .catch(error => this.signinFailed(error))
    },
    signinFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
      this.$store.commit('unsetCurrentUser')
    },
    checkSignedIn () {
      if (this.$store.state.signedIn) {
        this.$router.replace('/about_user')
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import '../assets/shared_auth_styles.css';
</style>
