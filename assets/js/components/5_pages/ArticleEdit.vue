<template>
  <div id="inspire" v-cloak>
    <TheNavigation :currentUser="currentUser" />
    <AppContent :article="article" />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from '../4_templates/TheNavigation.vue';
import TheFooter from '../4_templates/TheFooter.vue';
import AppContent from '../4_templates/contents/ArticleEditContent.vue';

export default {
  name: 'ArticleEdit',

  components: {
    'TheNavigation': TheNavigation,
    'AppContent': AppContent,
    'TheFooter': TheFooter
  },

  data () {
    return {
      toolbarTitle: 'Edit Article',
      article: gon.article,
      currentUser: gon.currentUser,
    }
  },
};
</script>
