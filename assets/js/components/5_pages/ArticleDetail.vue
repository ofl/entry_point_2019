<template>
  <div>
    <TheNavigation :currentUser="currentUser" />
    <AppContent
      :article="article"
      :currentUser="currentUser"
      :flashes="flashes"
    />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from '../4_templates/TheNavigation.vue';
import TheFooter from '../4_templates/TheFooter.vue';
import AppContent from '../4_templates/contents/ArticleDetailContent.vue';

export default {
  name: 'ArticleDetail',

  components: {
    'TheNavigation': TheNavigation,
    'AppContent': AppContent,
    'TheFooter': TheFooter
  },

  data () {
    return {
      toolbarTitle: 'Article',
      article: gon.article,
      currentUser: gon.currentUser,
      flashes: gon.flashJson,
    }
  },
};
</script>
