<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <GqlPagedArticleListContent :articles="articles" />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import GqlPagedArticleListContent from "../organisms/GqlPagedArticleListContent.vue";

import ARTICLE_INDEX_QUERY from "../../gqls/articles.gql";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "GqlArticleList",

  components: { GeneralTemplate, GqlPagedArticleListContent },

  data() {
    return {
      toolbarTitle: "Spa Articles",
      articles: [],
      currentUser: null,
      flashes: {}
    };
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY
    },
    articles: {
      query: ARTICLE_INDEX_QUERY
    }
  }
};
</script>
