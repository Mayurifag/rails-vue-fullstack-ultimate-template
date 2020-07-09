<template lang="pug">
  .auth-card
    el-card
      h2.mb-1em Forgot password
      el-form(ref="form" label-width="6em" @submit.native.prevent="submit")
        el-form-item(prop="email" label="Email")
          el-input(v-model="email" placeholder="Enter your email")
        el-form-item(label-width="0")
          el-button(type="primary" native-type="submit" block) Reset Password
      router-link(to="/") Sign In
      router-link(to="/signup" class="display-block mt-1em") Sign Up
</template>

<script>
export default {
  data () {
    return {
      email: '',
      error: '',
      notice: ''
    }
  },
  methods: {
    submit () {
      this.$http.plain.post('/api/users/password_resets', { email: this.email })
        .then(() => this.submitSuccessful())
        .catch(error => this.submitFailed(error))
    },
    submitSuccessful () {
      this.notice = 'Email with password reset instructions had been sent.'
      this.error = ''
      this.email = ''
    },
    submitFailed (error) {
      this.error = (error.response && error.response.data && error.response.data.error) || ''
    }
  }
}
</script>

<style lang="scss" scoped>
@import '../assets/shared_auth_styles.css';
</style>
