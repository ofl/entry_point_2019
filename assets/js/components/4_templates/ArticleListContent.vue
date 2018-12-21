<template>
  <section class="section main-contents">
    <TheFlashes :flashes="flashes" />

    <div class="container">
      <ArticleListTable :articles="articles" />

      <div class="new-button">
        <button class="button field is-info"
@click="onClickNewBtn()">
          <BIcon icon="pencil" />
          <span>New</span>
        </button>
      </div>
    </div>
  </section>
</template>

<script>
import ArticleListTable from "../3_organisms/ArticleListTable.vue";
import TheFlashes from "../3_organisms/TheFlashes.vue";

export default {
  name: "ArticleListContent",

  components: {
    ArticleListTable: ArticleListTable,
    TheFlashes: TheFlashes
  },

  props: {
    articles: {
      type: Array
    },
    flashes: {
      type: Object
    }
  },

  methods: {
    onClickNewBtn() {
      location.href = "/vue_articles/new";
    }
  }
};
</script>
