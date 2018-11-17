<template>
  <v-app id="inspire" v-cloak>
    <TheNavigation />
    <TheToolbar :title="toolbarTitle" />
    <AppContent :article="article" />
    <TheFooter />
  </v-app>
</template>

<script>
  import TheNavigation from '../templates/TheNavigation.vue';
  import TheToolbar from '../templates/TheToolbar.vue';
  import TheFooter from '../templates/TheFooter.vue';
  import AppContent from '../templates/contents/ArticleEditContent.vue';

  export default {
    name: 'ArticleEdit',

    components: {
      'TheNavigation': TheNavigation,
      'TheToolbar': TheToolbar,
      'AppContent': AppContent,
      'TheFooter': TheFooter
    },

    data () {
      return {
        toolbarTitle: 'Edit Article',
        article: gon.article,
      }
    },
  };
</script>


<style>
  [v-cloak] {
    /* display: none; */
  }
</style>
