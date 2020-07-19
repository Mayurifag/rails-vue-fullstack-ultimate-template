<template lang="pug">
  .auth-card
    el-card
      h2.mb-1em {{ $t('users.signIn') }}
      el-form(:model="signInForm" ref="signInForm" :rules="rules" label-width="6em")
        el-form-item(prop="email" label="Email")
          el-input(v-model="signInForm.email" :placeholder="$t('placeholders.users.enterYourEmail')" clearable)
        el-form-item(prop="password" :label="$t('users.password')")
          el-input(v-model="signInForm.password" :placeholder="$t('validations.users.enterYourPassword')" show-password autocomplete="off")
        el-form-item(label-width="0")
          el-button(type="primary" block @click="validateAndSignIn") {{ $t('users.login') }}
      router-link(to="/forgot_password") {{ $t('users.forgotPassword?') }}
      router-link(to="/signup" class="display-block mt-1em") {{ $t('users.signUp') }}
</template>

<script>
import usersApi from '@api/users'
import { mapActions, mapGetters } from 'vuex'

export default {
  data () {
    return {
      signInForm: {
        email: '',
        password: ''
      },
      rules: {
        email: [
          // I dont want to be maximum accurate for email regexp
          { required: true, pattern: /^\S+@\S+\.\S+$/, message: this.$t('validations.users.enterCorrectEmail'), trigger: 'blur' }
        ],
        password: [
          { required: true, message: this.$t('validations.users.enterYourPassword'), trigger: 'blur' }
        ]
      }
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
    validateAndSignIn () {
      this.$refs.signInForm.validate((valid) => {
        if (valid) {
          usersApi.signIn(this.signInForm.email, this.signInForm.password)
            .then(response => this.signinSuccessful(response))
            .catch(error => this.signinFailed(error))
        }
      })
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
      const errorMessage = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
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
