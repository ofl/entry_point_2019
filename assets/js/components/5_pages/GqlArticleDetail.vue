<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <GqlArticleDetailContent
      :article="article"
      :article-id="articleId"
      :current-user="currentUser"
    />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../4_templates/GeneralTemplate.vue";
import GqlArticleDetailContent from "../3_organisms/GqlArticleDetailContent.vue";

import ARTICLE_DETAIL_QUERY from "../../gqls/article.gql";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "GqlArticleDetail",

  components: { GeneralTemplate, GqlArticleDetailContent },

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
    },
    article: {
      query: ARTICLE_DETAIL_QUERY,
      variables() {
        return {
          id: this.articleId
        };
      }
    }
  }
};
</script>
