<template>
  <GeneralTemplate :current-user="currentUser" :flashes="flashes">
    <ArticleListContent :articles="articles"/>
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import ArticleListContent from "../organisms/ArticleListContent.vue";

export default {
  name: "ArticleList",

  components: { GeneralTemplate, ArticleListContent },

  data() {
    return {
      toolbarTitle: "Articles",
      articles: gon.articles,
      currentUser: gon.currentUser,
      flashes: gon.flashJson
    };
  }
};
</script>
