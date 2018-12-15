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
import AppContent from "../4_templates/contents/InlineGqlArticleDetailContent.vue";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "InlineGqlArticleDetail",

  components: {
    TheNavigation: TheNavigation,
    AppContent: AppContent,
    TheFooter: TheFooter
  },

  data() {
    return {
      toolbarTitle: "Article",
      currentUser: gon.currentUser,
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
      query: CURRENT_USER_QUERY,
      skip() {
        return this.hasInlineData;
      }
    }
  },

  mounted() {
    if (this.hasInlineData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: CURRENT_USER_QUERY,
        data: { currentUser: gon.currentUser }
      });
    }
  }
};
</script>
