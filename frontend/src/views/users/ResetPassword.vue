<template lang="pug">
  .auth-card
    el-card
      h2.mb-1em Reset password
      el-form(ref="form" label-width="8em" @submit.native.prevent="reset")
        el-form-item(prop="password" label="Password")
          el-input(v-model="password" placeholder="Enter your password" show-password)
        el-form-item(prop="password_confirmation" label="Pass confirm")
          el-input(v-model="password_confirmation" placeholder="Confirm your password" show-password)
        el-form-item(label-width="0")
          el-button(type="primary" native-type="submit" block) Reset Password
      router-link(to="/") Sign In
      router-link(to="/signup" class="display-block mt-1em") Sign Up
</template>

<script>
export default {
  data () {
    return {
      password: '',
      password_confirmation: '',
      error: '',
      notice: ''
    }
  },
  created () {
    this.checkPasswordToken()
  },
  methods: {
    reset () {
      this.$http.plain.patch(`/api/users/password_resets/${this.$route.params.token}`, { password: this.password, password_confirmation: this.password_confirmation })
        .then(response => this.resetSuccessful(response))
        .catch(error => this.resetFailed(error))
    },
    resetSuccessful (response) {
      this.notice = 'Your password has been reset successfully! Please sign in with your new password.'
      this.error = ''
      this.password = ''
      this.password_confirmation = ''
      this.$router.replace('/')
    },
    resetFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      this.notice = ''
    },
    checkPasswordToken () {
      this.$http.plain.get(`/api/users/password_resets/${this.$route.params.token}`)
        .catch(error => {
          this.resetFailed(error)
          this.$router.replace('/')
        })
    }
  }
}
</script>
