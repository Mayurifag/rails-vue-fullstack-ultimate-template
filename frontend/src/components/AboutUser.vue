<template lang="pug">
  el-row(type="flex" justify="space-around")
    | Your email is {{ user.email }} and you are {{ user.role }} user.
</template>

<script>
import usersApi from '@api/users'
import messageToast from '@lib/messageToast'
// import { mapGetters } from 'vuex'

export default {
  data () {
    return {
      user: {}
    }
  },
  created () {
    if (!this.$store.state.user.signedIn) {
      messageToast.showMessage('Authorize before continue')
      this.$router.replace('/')
    } else {
      usersApi.securedWhoami()
        .then(response => { this.user = response.data })
        .catch(error => { this.showError(error, 'Something went wrong') })
    }
  },
  methods: {
    showError (error, text) {
      const msgError = (error.response && error.response.data && error.response.data.error) || text
      messageToast.showError(msgError)
    }
  }
}
</script>
