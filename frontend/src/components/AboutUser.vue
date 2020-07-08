<template lang="pug">
  el-row(type="flex" justify="space-around")
    | Your email is {{ user.email }} and you are {{ user.role }} user.
</template>

<script>
export default {
  data () {
    return {
      user: {}
    }
  },
  created () {
    if (!this.$store.state.signedIn) {
      this.$router.replace('/')
    } else {
      this.$http.secured.get('/api/users/whoami')
        .then(response => { this.user = response.data })
        .catch(error => { this.setError(error, 'Something went wrong') })
    }
  },
  methods: {
    setError (error, text) {
      this.error = (error.response && error.response.data && error.response.data.error) || text
    }
  }
}
</script>
