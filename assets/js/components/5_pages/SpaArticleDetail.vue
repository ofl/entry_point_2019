<template>
  <div>
    <TheNavigation :current-user="currentUser" />
    <AppContent
      :article-id="articleId"
      :current-user="currentUser"
      :flashes="flashes"
    />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from "../4_templates/TheNavigation.vue";
import TheFooter from "../4_templates/TheFooter.vue";
// import AppContent from '../4_templates/contents/ArticleDetailContent.vue';
import AppContent from "../4_templates/contents/GqlArticleDetailContent.vue";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "SpaArticleDetail",

  components: {
    TheNavigation: TheNavigation,
    AppContent: AppContent,
    TheFooter: TheFooter
  },

  data() {
    return {
      toolbarTitle: "Article",
      // currentUser: gon.currentUser,
      currentUser: null,
      flashes: {}
    };
  },

  computed: {
    articleId() {
      return parseInt(this.$route.params.id, 10);
    }
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY
    }
  }
};
</script>
