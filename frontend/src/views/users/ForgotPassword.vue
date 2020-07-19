<template lang="pug">
  .auth-card
    el-card
      h2.mb-1em {{ $t('users.resetPassword') }}
      el-form(label-width="6em" :model="forgotPasswordForm" ref="forgotPasswordForm" :rules="rules")
        el-form-item(prop="email" label="Email")
          el-input(v-model="forgotPasswordForm.email" :placeholder="$t('placeholders.users.enterYourEmail')" clearable)
        el-form-item(label-width="0")
          el-button(type="primary" :disabled="forgotPasswordForm.email === ''" @click="validateAndSetResetPasswordToken" block) {{ $t('users.resetPassword') }}
      router-link(to="/") {{ $t('users.signIn') }}
      router-link(to="/signup" class="display-block mt-1em") {{ $t('users.signUp') }}
</template>

<script>
import usersApi from '@api/users'
import messageToast from '@lib/messageToast'

export default {
  data () {
    return {
      forgotPasswordForm: {
        email: ''
      },
      rules: {
        email: [
          // I dont want to be maximum accurate for email regexp
          { required: true, pattern: /^\S+@\S+\.\S+$/, message: 'Enter correct email', trigger: 'blur' }
        ]
      }
    }
  },
  methods: {
    validateAndSetResetPasswordToken () {
      usersApi.setResetPasswordToken(this.forgotPasswordForm.email)
        .then((response) => this.submitSuccessful(response))
        .catch(error => this.submitFailed(error))
    },
    submitSuccessful (response) {
      messageToast.showSuccess(response.data)
      this.forgotPasswordForm.email = ''
      this.$router.replace('/')
    },
    submitFailed (error) {
      const errorMessage = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      messageToast.showError(errorMessage)
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@assets/shared_auth_styles'
</style>
