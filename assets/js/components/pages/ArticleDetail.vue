<template>
  <div id="inspire" v-cloak>
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
import TheNavigation from '../templates/TheNavigation.vue';
import TheFooter from '../templates/TheFooter.vue';
import AppContent from '../templates/contents/ArticleDetailContent.vue';

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
