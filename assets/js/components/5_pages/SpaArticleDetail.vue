<template>
  <div>
    <TheNavigation :currentUser="currentUser" />
    <AppContent
      :articleId="articleId"
      :currentUser="currentUser"
      :flashes="flashes"
    />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from '../4_templates/TheNavigation.vue';
import TheFooter from '../4_templates/TheFooter.vue';
// import AppContent from '../4_templates/contents/ArticleDetailContent.vue';
import AppContent from '../4_templates/contents/GqlArticleDetailContent.vue';
import CURRENT_USER_QUERY from '../../gqls/currentUser.gql';

export default {
  name: 'SpaArticleDetail',

  components: {
    'TheNavigation': TheNavigation,
    'AppContent': AppContent,
    'TheFooter': TheFooter
  },

  computed: {
    articleId () {
      return parseInt(this.$route.params.id, 10);
    },
  },

  data () {
    return {
      toolbarTitle: 'Article',
      // currentUser: gon.currentUser,
      currentUser: null,
      flashes: {},
    }
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY,
    }
  },
};
</script>
