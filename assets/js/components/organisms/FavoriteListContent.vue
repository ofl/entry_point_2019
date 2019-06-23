<template>
  <div class="container">
    <ArticleListTable :articles="articles"/>
  </div>
</template>

<script>
import ArticleListTable from "../organisms/InlineGqlArticleListTable.vue";

export default {
  name: "ArticleListContent",

  components: { ArticleListTable },

  props: {
    articles: {
      type: Array
    }
  }
};
</script>
