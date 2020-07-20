<template lang="pug">
  el-menu(:router="true" :default-active="activeLink" mode="horizontal")
    .dock-right
      SelectLocale
      template(v-if="this.isAuthorized")
        el-submenu(index='/about_user')
          template(slot="title") {{ this.getEmail }}
          el-menu-item(@click="LogoutUser") {{ $t('users.logout') }}
      template(v-else)
        el-menu-item(index='/') {{ $t('users.signIn') }}
        el-menu-item(index='/signup') {{ $t('users.signUp') }}
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
  mounted () {
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
  display: inline-flex;
  flex-wrap: nowrap;
  align-items: center;
  justify-content: flex-end;
  float: right !important;
}
</style>
