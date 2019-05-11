<template>
  <div class="box content">
    <ArticleListItem v-for="article in articles" :key="articleKey(article.id)" :article="article"/>
  </div>
</template>

<script>
import ArticleListItem from "../molecules/ArticleListItem.vue";

export default {
  name: "ArticleListTable",

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
