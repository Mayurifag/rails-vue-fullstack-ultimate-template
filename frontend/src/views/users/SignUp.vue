<template lang="pug">
  .auth-card
    el-card
      h2.mb-1em Sign up
      el-form(label-width="8em" @submit.native.prevent="signup")
        el-form-item(prop="email" label="Email")
          el-input(v-model="email" placeholder="Enter your email" clearable)
        el-form-item(prop="password" label="Password")
          el-input(v-model="password" placeholder="Enter your password" show-password)
        el-form-item(prop="password_confirmation" label="Pass confirm")
          el-input(v-model="password_confirmation" placeholder="Confirm your password" show-password)

        el-form-item(label-width="0")
          el-button(type="primary" native-type="submit" block) Sign up
      router-link(to="/forgot_password") Forgot Password?
      router-link(to="/" class="display-block mt-1em") Sign In
</template>

<script>
export default {
  data () {
    return {
      email: '',
      password: '',
      password_confirmation: '',
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
    signup () {
      this.$http.plain.post('/api/users/signup', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }
      this.$http.plain.get('/api/users/whoami')
        .then(meResponse => {
          this.$store.commit('setCurrentUser', { currentUser: meResponse.data, csrf: response.data.csrf })
          this.error = ''
          this.$router.replace('/about_user')
        })
        .catch(error => this.signupFailed(error))
    },
    signupFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
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
@import '@assets/shared_auth_styles'
</style>
