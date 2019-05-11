<template>
  <div class="container">
    <ArticleListTable :articles="articles"/>

    <div class="new-button">
      <button class="button field is-info" @click="onClickNewBtn()">
        <BIcon icon="pencil"/>
        <span>New</span>
      </button>
    </div>
  </div>
</template>

<script>
import ArticleListTable from "../organisms/GqlArticleListTable.vue";

export default {
  name: "GqlArticleListContent",

  components: { ArticleListTable },

  props: {
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
