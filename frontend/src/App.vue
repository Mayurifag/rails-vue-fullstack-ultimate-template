<template lang="pug">
  #app
    AppHeader
    router-view
</template>

<script>
import AppHeader from '@/components/AppHeader'

export default {
  components: { AppHeader }
}
</script>
