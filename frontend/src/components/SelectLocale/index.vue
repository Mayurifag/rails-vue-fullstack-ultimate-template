<template lang="pug">
  .languages
    img(
      class="flag"
      v-for="lang in this.getLanguagesArrayWithoutCurrent"
      v-on:click="changeLanguage(lang)"
      :src="require(`@/assets/languages/${lang}.png`)"
    )
</template>

<script>
import { mapGetters, mapActions } from 'vuex'

export default {
  name: 'SelectLocale',
  computed: {
    ...mapGetters('application', ['getLanguagesArrayWithoutCurrent', 'getLanguage'])
  },
  methods: {
    ...mapActions('application', ['setLanguage']),
    changeLanguage (lang) {
      this.$i18n.locale = lang
      this.setLanguage(lang)
    }
  }
}
</script>

<style lang="scss" scoped>
.flag {
  height: 24px;
  margin-right: 12px;

  &:hover {
    cursor: pointer
  }
}
</style>
