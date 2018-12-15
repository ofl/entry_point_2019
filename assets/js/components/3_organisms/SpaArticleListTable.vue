<template>
  <div class="box content">
    <ArticleListItem
      v-for="(article, index) in articles"
      :key="articleKey(article.id)"
      :article="article"
    />
  </div>
</template>

<script>
import ArticleListItem from "../2_molecules/SpaArticleListItem.vue";

export default {
  name: "SpaArticleListTable",

  components: {
    ArticleListItem: ArticleListItem
  },

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
