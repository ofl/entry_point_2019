<template>
  <v-app id="inspire" v-cloak>
    <TheNavigation :currentUser="currentUser" />
    <TheToolbar :title="toolbarTitle" />
    <AppContent
      :article="article"
      :currentUser="currentUser"
      :flashes="flashes"
    />
    <TheFooter />
  </v-app>
</template>

<script>
  import TheNavigation from '../templates/TheNavigation.vue';
  import TheToolbar from '../templates/TheToolbar.vue';
  import TheFooter from '../templates/TheFooter.vue';
  import AppContent from '../templates/contents/ArticleDetailContent.vue';

  export default {
    name: 'ArticleDetail',

    components: {
      'TheNavigation': TheNavigation,
      'TheToolbar': TheToolbar,
      'AppContent': AppContent,
      'TheFooter': TheFooter
    },

    props: {
      rails: {
        type: Object
      }
    },

    data () {
      return {
        toolbarTitle: 'Article',
        article: rails.article,
        currentUser: rails.currentUser,
        flashes: rails.flashJson,
      }
    },
  };
</script>

<style>
  [v-cloak] {
    /* display: none; */
  }
</style>
