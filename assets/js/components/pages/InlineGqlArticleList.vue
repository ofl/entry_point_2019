<i18n src="../../i18n/articleList.json" />

<template>
  <GeneralTemplate :current-user="currentUser" :flashes="flashes">
    <InlineGqlArticleListContent :articles="articles" :current-user="currentUser" @search="search"/>
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import InlineGqlArticleListContent from "../organisms/InlineGqlArticleListContent.vue";

import ARTICLE_INDEX_QUERY from "../../gqls/articles.gql";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";
import SEARCH_ARTICLES_QUERY from "../../gqls/searchArticles.gql";

import SetTitleMixin from "../../utils/setTitle";

export default {
  name: "InlineGqlArticleList",

  components: { GeneralTemplate, InlineGqlArticleListContent },

  mixins: [SetTitleMixin],

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
  },

  methods: {
    async search(keyword) {
      await this.$apollo
        .query({
          query: SEARCH_ARTICLES_QUERY,
          variables: {
            keyword: keyword
          }
        })
        .then(data => {
          this.articles = data.data.searchArticles;
        })
        .catch(error => {
          // Error
          console.error(error);
        });
    }
  }
};
</script>
