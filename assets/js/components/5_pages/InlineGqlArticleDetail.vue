<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <InlineGqlArticleDetailContent
      :article="article"
      :article-id="articleId"
      :current-user="currentUser"
    />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../4_templates/GeneralTemplate.vue";
import InlineGqlArticleDetailContent from "../3_organisms/InlineGqlArticleDetailContent.vue";

import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "InlineGqlArticleDetail",

  components: { GeneralTemplate, InlineGqlArticleDetailContent },

  data() {
    return {
      toolbarTitle: "Article",
      currentUser: gon.currentUser,
      article: gon.article,
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
