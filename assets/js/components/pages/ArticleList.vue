<template>
  <div id="inspire" v-cloak>
    <TheNavigation :currentUser="currentUser" />
    <AppContent
      :articles="articles"
      :flashes="flashes"
    />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from '../templates/TheNavigation.vue';
import TheFooter from '../templates/TheFooter.vue';
import AppContent from '../templates/contents/ArticleListContent.vue';

export default {
  name: 'ArticleList',

  components: {
    'TheNavigation': TheNavigation,
    'AppContent': AppContent,
    'TheFooter': TheFooter
  },

  data () {
    return {
      toolbarTitle: 'Articles',
      articles: gon.articles,
      currentUser: gon.currentUser,
      flashes: gon.flashJson,
    }
  },
};
</script>
