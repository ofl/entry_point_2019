<template>
  <div>
    <TheNavigation :currentUser="currentUser" />
    <AppContent
      :articles="articles"
      :flashes="flashes"
    />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from '../4_templates/TheNavigation.vue';
import TheFooter from '../4_templates/TheFooter.vue';
import AppContent from '../4_templates/contents/SpaPagedArticleListContent.vue';

export default {
  name: 'SpaArticleList',

  components: {
    'TheNavigation': TheNavigation,
    'AppContent': AppContent,
    'TheFooter': TheFooter
  },

  data () {
    return {
      toolbarTitle: 'Spa Articles',
      articles: [],
      currentUser: null,
      flashes: {},
    }
  },
};
</script>
