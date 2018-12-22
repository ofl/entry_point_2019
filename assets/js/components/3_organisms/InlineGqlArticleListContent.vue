<template>
  <div class="container">
    <ArticleListTable :articles="articles" />

    <div v-if="currentUser"
class="new-button">
      <RouterLink
        class="button field is-info"
        :to="{ name: 'InlineGqlArticleNew' }"
      >
        <BIcon icon="pencil" />
        <span>New</span>
      </RouterLink>
    </div>
  </div>
</template>

<script>
import ArticleListTable from "../3_organisms/InlineGqlArticleListTable.vue";

import ARTICLE_INDEX_QUERY from "../../gqls/articles.gql";

export default {
  name: "InlineGqlArticleListContent",

  components: { ArticleListTable: ArticleListTable },

  props: {
    currentUser: {
      type: Object
    }
  },

  data() {
    return {
      articles: gon.articles
    };
  },

  computed: {
    hasInlineData() {
      return !!gon.articles && gon.articles.length > 0;
    }
  },

  apollo: {
    articles: {
      query: ARTICLE_INDEX_QUERY,
      skip() {
        return this.hasInlineData;
      }
    }
  },

  mounted() {
    if (this.hasInlineData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: ARTICLE_INDEX_QUERY,
        data: { articles: gon.articles }
      });
    }
  },

  methods: {
    onClickNewBtn() {
      location.href = "/vue_articles/new";
    }
  }
};
</script>
