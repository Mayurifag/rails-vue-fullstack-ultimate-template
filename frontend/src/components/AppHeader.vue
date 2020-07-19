<template lang="pug">
  el-menu(:router="true" :default-active="activeLink" mode="horizontal")
    SelectLocale
    template(v-if="this.isAuthorized")
      .dock-right
        el-submenu(index='/about_user')
          template(slot="title") {{ this.getEmail }}
          el-menu-item(@click="LogoutUser") {{ $t('users.logout') }}
    template(v-else)
      el-menu-item.dock-right(index='/') {{ $t('users.signIn') }}
      el-menu-item.dock-right(index='/signup') {{ $t('users.signUp') }}
</template>

<script>
import { mapActions, mapGetters } from 'vuex'
import SelectLocale from '@components/SelectLocale'

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
  computed: {
    ...mapGetters('user', ['isAuthorized', 'getEmail'])
  },
  mounted: function () {
    this.activeLink = this.$route.path
  },
  methods: {
    ...mapActions('user', ['unsetCurrentUser']),
    LogoutUser () {
      this.unsetCurrentUser({})
      this.$router.replace('/')
    }
  },
  components: {
    SelectLocale
  }
}
</script>

<style lang="scss" scoped>
.dock-right {
  float: right !important;
}
</style>
