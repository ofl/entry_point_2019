<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <SpaPagedArticleListContent :articles="articles" />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../4_templates/GeneralTemplate.vue";
import SpaPagedArticleListContent from "../3_organisms/SpaPagedArticleListContent.vue";

import ARTICLE_INDEX_QUERY from "../../gqls/articles.gql";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "SpaArticleList",

  components: { GeneralTemplate, SpaPagedArticleListContent },

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
