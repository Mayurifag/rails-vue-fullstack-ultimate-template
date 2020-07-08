<template lang="pug">
  el-menu(:router="true" :default-active="activeLink" mode="horizontal")
      template(v-if="this.$store.state.signedIn")
        .dock-right
          el-submenu(index='/about_user' show-timeout=0 hide-timeout=100)
            template(slot="title") {{ this.$store.state.currentUser.email }}
            el-menu-item(@click="LogoutUser") Logout
      template(v-else)
        el-menu-item.dock-right(index='/') Login
        el-menu-item.dock-right(index='/signup') Sign up
</template>

<script>
export default {
  data () {
    return {
      activeLink: null
    }
  },

  watch: {
    $route (to, from) {
      this.activeLink = to.path
    }
  },
  mounted: function () {
    this.activeLink = this.$route.path
  },
  methods: {
    LogoutUser () {
      this.$store.commit('unsetCurrentUser')
      this.$router.replace('/')
    }
  }
}
</script>
<style lang="scss" scoped>
  .dock-right {
    float: right !important;
  }
</style>
