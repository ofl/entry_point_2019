<template>
  <GeneralTemplate :current-user="currentUser" :flashes="flashes">
    <GqlArticleDetailContent
      :article="article"
      :article-id="articleId"
      :current-user="currentUser"
    />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import GqlArticleDetailContent from "../organisms/GqlArticleDetailContent.vue";

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
      return this.$route.params.id;
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
