<template>
  <div class="container">
    <ArticleListTable :articles="articles"/>

    <div v-if="currentUser" class="new-button">
      <RouterLink class="button field is-info" :to="{ name: 'InlineGqlArticleNew' }">
        <BIcon icon="pencil"/>
        <span>New</span>
      </RouterLink>
    </div>
  </div>
</template>

<script>
import ArticleListTable from "../organisms/InlineGqlArticleListTable.vue";

export default {
  name: "InlineGqlArticleListContent",

  components: { ArticleListTable: ArticleListTable },

  props: {
    currentUser: {
      type: Object
    },
    articles: {
      type: Array
    }
  },

  methods: {
    onClickNewBtn() {
      location.href = "/vue_articles/new";
    }
  }
};
</script>
