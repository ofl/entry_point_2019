<template>
  <div class="box content">
    <ArticleListItem v-for="article in articles" :key="articleKey(article.id)" :article="article"/>
  </div>
</template>

<script>
import ArticleListItem from "../molecules/GqlArticleListItem.vue";

export default {
  name: "GqlArticleListTable",

  components: { ArticleListItem },

  props: {
    articles: {
      type: Array
    }
  },

  methods: {
    articleKey(id) {
      return `article-${id}`;
    }
  }
};
</script>
