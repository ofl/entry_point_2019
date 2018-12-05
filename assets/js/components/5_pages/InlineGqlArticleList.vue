<template>
  <div>
    <TheNavigation :currentUser="currentUser" />
    <AppContent
      :currentUser="currentUser"
      :articles="articles"
      :flashes="flashes"
    />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from '../4_templates/TheNavigation.vue';
import TheFooter from '../4_templates/TheFooter.vue';
import AppContent from '../4_templates/contents/InlineGqlArticleListContent.vue';
import CURRENT_USER_QUERY from '../../gqls/currentUser.gql';

export default {
  name: 'InlineGqlArticleList',

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

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY,
      skip() {
        return !!gon.currentUser;
      },
    }
  },

  mounted () {
    if (!!gon.currentUser) {
      this.currentUser = gon.currentUser;

      this.$apollo.provider.defaultClient.writeQuery({
        query: CURRENT_USER_QUERY,
        data: {
          currentUser: Object.assign(gon.currentUser, { __typename: 'currentUser' }),
        },
      });
    }
  },
};
</script>
