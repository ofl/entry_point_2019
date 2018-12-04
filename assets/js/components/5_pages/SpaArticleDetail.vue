<template>
  <div>
    <TheNavigation :currentUser="currentUser" />
    <AppContent
      :articleId="$route.params.id"
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

export default {
  name: 'SpaArticleDetail',

  components: {
    'TheNavigation': TheNavigation,
    'AppContent': AppContent,
    'TheFooter': TheFooter
  },

  data () {
    return {
      toolbarTitle: 'Article',
      currentUser: gon.currentUser,
      flashes: {},
    }
  },
};
</script>
