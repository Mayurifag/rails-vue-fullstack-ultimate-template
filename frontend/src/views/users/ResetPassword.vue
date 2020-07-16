<template lang="pug">
  .auth-card
    el-card
      h2.mb-1em Reset password
      el-form(label-width="8em" :model="resetPasswordForm" ref="resetPasswordForm" :rules="rules")
        el-form-item(prop="password" required label="Password")
          el-input(v-model="resetPasswordForm.password" placeholder="Enter your password" show-password autocomplete="off")
        el-form-item(prop="passwordConfirmation" required label="Pass confirm")
          el-input(v-model="resetPasswordForm.passwordConfirmation" placeholder="Confirm your password" show-password autocomplete="off")
        el-form-item(label-width="0")
          el-button(type="primary" @click="validateAndReset" block) Reset Password
      router-link(to="/") Sign In
      router-link(to="/signup" class="display-block mt-1em") Sign Up
</template>

<script>
import usersApi from '@api/users'
import messageToast from '@lib/messageToast'

export default {
  data () {
    return {
      resetPasswordForm: {
        password: '',
        passwordConfirmation: ''
      },
      rules: {
        password: [
          { validator: this.validatePassword, trigger: 'blur' }
        ],
        passwordConfirmation: [
          { validator: this.validatePasswordConfirmation, trigger: 'blur' }
        ]
      }
    }
  },
  created () {
    this.checkPasswordToken()
  },
  methods: {
    validateAndReset () {
      usersApi.resetPassword(this.$route.params.token, this.resetPasswordForm.password, this.resetPasswordForm.passwordConfirmation)
        .then(response => this.resetSuccessful(response))
        .catch(error => this.resetFailed(error))
    },
    resetSuccessful (response) {
      messageToast.showMessage('Your password has been reset successfully! Please sign in with your new password')
      this.resetPasswordForm.password = ''
      this.resetPasswordForm.password_confirmation = ''
      this.$router.replace('/')
    },
    resetFailed (error) {
      const errorMessage = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      messageToast.showError(errorMessage)
    },
    checkPasswordToken () {
      usersApi.checkPasswordToken(this.$route.params.token)
        .catch(error => {
          this.resetFailed(error)
          this.$router.replace('/')
        })
    },
    validatePassword (rule, value, callback) {
      if (value === '') {
        callback(new Error('Please input the password'))
      } else {
        if (this.resetPasswordForm.passwordConfirmation !== '') {
          this.$refs.resetPasswordForm.validateField('passwordConfirmation')
        }
        callback()
      }
    },
    validatePasswordConfirmation (rule, value, callback) {
      if (value === '') {
        callback(new Error('Please input the password again'))
      } else if (value !== this.resetPasswordForm.password) {
        callback(new Error('Passwords aren\'t equal, please check them'))
      } else {
        callback()
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@assets/shared_auth_styles'
</style>
