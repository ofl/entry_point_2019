<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <InlineGqlArticleListContent
      :articles="articles"
      :current-user="currentUser"
    />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import InlineGqlArticleListContent from "../organisms/InlineGqlArticleListContent.vue";

import ARTICLE_INDEX_QUERY from "../../gqls/articles.gql";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "InlineGqlArticleList",

  components: { GeneralTemplate, InlineGqlArticleListContent },

  data() {
    return {
      toolbarTitle: "Inline+GQL Articles",
      currentUser: gon.currentUser,
      articles: gon.articles,
      flashes: gon.flashJson
    };
  },

  computed: {
    hasInlineUserData() {
      return !!gon.currentUser;
    },
    hasInlineArticlesData() {
      return !!gon.articles;
    }
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY,
      skip() {
        return this.hasInlineUserData;
      }
    },
    articles: {
      query: ARTICLE_INDEX_QUERY,
      skip() {
        return this.hasInlineArticlesData;
      }
    }
  },

  mounted() {
    // Gonからデータを取得した場合、Apollo client キャッシュへの書き込む

    if (this.hasInlineUserData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: CURRENT_USER_QUERY,
        data: { currentUser: gon.currentUser }
      });
    }

    if (this.hasInlineArticlesData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: ARTICLE_INDEX_QUERY,
        data: { articles: gon.articles }
      });
    }
  }
};
</script>
