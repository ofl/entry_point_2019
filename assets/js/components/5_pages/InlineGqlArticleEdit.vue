<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <InlineGqlArticleEditContent
      :current-user="currentUser"
      :article-id="articleId"
    />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../4_templates/GeneralTemplate.vue";
import InlineGqlArticleEditContent from "../3_organisms/InlineGqlArticleEditContent.vue";

import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "ArticleEdit",

  components: { GeneralTemplate, InlineGqlArticleEditContent },

  data() {
    return {
      toolbarTitle: "Edit Article",
      currentUser: gon.currentUser,
      flashes: gon.flashes
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
