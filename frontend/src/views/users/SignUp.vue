<template lang="pug">
  .auth-card
    el-card
      h2.mb-1em {{ $t('users.signUp') }}
      el-form(:model="signUpForm" ref="signUpForm" :rules="rules" label-position="right")
        el-form-item(prop="email" label="Email")
          el-input(v-model="signUpForm.email" :placeholder="$t('placeholders.users.enterYourEmail')" clearable)
        el-form-item(prop="password" required :label="$t('users.password')")
          el-input(v-model="signUpForm.password" :placeholder="$t('validations.users.enterYourPassword')" show-password autocomplete="off")
        el-form-item(prop="passwordConfirmation" required :label="$t('users.passwordConfirmation')")
          el-input(v-model="signUpForm.passwordConfirmation" :placeholder="$t('placeholders.users.confirmPassword')" show-password autocomplete="off")
        el-form-item(label-width="0")
          el-button(type="primary" :disabled="signUpForm.email === ''" @click="validateAndSignUp" block) {{ $t('users.signUp') }}
      router-link(to="/forgot_password") {{ $t('users.forgotPassword?') }}
      router-link(to="/" class="display-block mt-1em") {{ $t('users.signIn') }}
</template>

<script>
import usersApi from '@api/users'
import { mapActions, mapGetters } from 'vuex'

export default {
  data () {
    return {
      signUpForm: {
        email: '',
        password: '',
        passwordConfirmation: ''
      },
      rules: {
        email: [
          // I dont want to be maximum accurate for email regexp
          { required: true, pattern: /^\S+@\S+\.\S+$/, message: 'Enter correct email', trigger: 'blur' }
        ],
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
    this.checkSignedIn()
  },
  updated () {
    this.checkSignedIn()
  },
  computed: {
    ...mapGetters('user', ['isAuthorized'])
  },
  methods: {
    ...mapActions('user', ['unsetCurrentUser', 'setCurrentUser']),
    validateAndSignUp () {
      usersApi.signUp(this.signUpForm.email, this.signUpForm.password, this.signUpForm.passwordConfirmation)
        .then(response => this.signupSuccessful(response))
        .catch(error => this.signupFailed(error))
    },
    signupSuccessful (response) {
      if (!response.data.csrf) {
        this.signupFailed(response)
        return
      }
      usersApi.whoami()
        .then(whoamiResponse => {
          this.setCurrentUser({ currentUser: whoamiResponse.data, csrf: response.data.csrf })
          this.$router.replace('/about_user')
        })
        .catch(error => this.signupFailed(error))
    },
    signupFailed (error) {
      const errorMessage = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      this.unsetCurrentUser({ errorMessage: errorMessage })
    },
    checkSignedIn () {
      if (this.isAuthorized) {
        this.$router.replace('/about_user')
      }
    },
    validatePassword (rule, value, callback) {
      if (value === '') {
        callback(new Error('Please input the password'))
      } else {
        if (this.signUpForm.passwordConfirmation !== '') {
          this.$refs.signUpForm.validateField('passwordConfirmation')
        }
        callback()
      }
    },
    validatePasswordConfirmation (rule, value, callback) {
      if (value === '') {
        callback(new Error('Please input the password again'))
      } else if (value !== this.signUpForm.password) {
        callback(new Error('Passwords aren\'t equal, please check them'))
      } else {
        callback()
      }
    }
  }
}
</script>

<style lang="scss" scoped>
@import '@styles/shared_auth_styles'
</style>
