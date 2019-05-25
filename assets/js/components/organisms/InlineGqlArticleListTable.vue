<template>
  <div class="box content">
    <ArticleListItem v-for="article in articles" :key="articleKey(article.id)" :article="article"/>

    <p v-if="noArticles">記事はありません</p>
  </div>
</template>

<script>
import ArticleListItem from "../molecules/InlineGqlArticleListItem.vue";

export default {
  name: "InlineGqlListTable",

  components: { ArticleListItem },

  props: {
    articles: {
      type: Array
    }
  },

  computed: {
    noArticles() {
      return !this.articles || this.articles.length == 0;
    }
  },

  methods: {
    articleKey(id) {
      return `article-${id}`;
    }
  }
};
</script>
