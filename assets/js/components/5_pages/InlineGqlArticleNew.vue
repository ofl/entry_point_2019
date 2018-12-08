<template>
  <div>
    <TheNavigation :currentUser="currentUser" />
    <AppContent
      :currentUser="currentUser"
      :flashes="flashes"
    />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from '../4_templates/TheNavigation.vue';
import TheFooter from '../4_templates/TheFooter.vue';
import AppContent from '../4_templates/contents/InlineGqlArticleNewContent.vue';
import CURRENT_USER_QUERY from '../../gqls/currentUser.gql';

export default {
  name: 'ArticleNew',

  components: {
    'TheNavigation': TheNavigation,
    'AppContent': AppContent,
    'TheFooter': TheFooter
  },

  data () {
    return {
      toolbarTitle: 'New Article',
      currentUser: gon.currentUser,
      flashes: gon.flashes,
    }
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY,
      skip() {
        return this.hasInlineData;
      },
    }
  },

  mounted () {
    if (this.hasInlineData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: CURRENT_USER_QUERY,
        data: { currentUser: gon.currentUser }
      });
    }
  },
};
</script>
