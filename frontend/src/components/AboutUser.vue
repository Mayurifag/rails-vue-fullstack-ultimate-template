<template>
  <div>
    <AppHeader></AppHeader>
    <h3>About User</h3>
  </div>
</template>

<script>
import AppHeader from '@/components/AppHeader'

export default {
  name: 'AboutUser',
  created () {
    if (!this.$store.state.signedIn) {
      this.$router.replace('/')
    }
  },
  components: { AppHeader }
}
</script>
