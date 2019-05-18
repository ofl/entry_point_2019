<template>
  <div class="container">
    <SearchForm @search="search" class="search-form"/>

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
import SearchForm from "../molecules/SearchForm.vue";

export default {
  name: "InlineGqlArticleListContent",

  components: { ArticleListTable: ArticleListTable, SearchForm },

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
    },
    search(keyword) {
      console.log(keyword);
    }
  }
};
</script>

<style scoped>
.search-form {
  margin: 1rem 0 1rem 0;
}
</style>
