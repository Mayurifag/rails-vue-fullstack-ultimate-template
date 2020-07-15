<template lang="pug">
  el-row(type="flex" justify="space-around")
    | Your email is {{ user.email }} and you are {{ user.role }} user.
</template>

<script>
import usersApi from '@api/users'
import messageToast from '@lib/messageToast'

export default {
  data () {
    return {
      user: {}
    }
  },
  created () {
    if (this.$store.state.user.signedIn) {
      usersApi.securedWhoami()
        .then(response => { this.user = response.data })
        .catch(error => { this.showError(error) })
    } else {
      messageToast.showMessage('Authorize before continue')
      this.$router.replace('/')
    }
  },
  methods: {
    showError (error) {
      const msgError = (error.response && error.response.data && error.response.data.error) || 'Something went wrong'
      messageToast.showError(msgError)
    }
  }
}
</script>
