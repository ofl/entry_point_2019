<template>
  <GeneralTemplate :current-user="currentUser" :flashes="flashes">
    <ArticleEditContent :article="article" :current-user="currentUser"/>
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import ArticleEditContent from "../organisms/ArticleEditContent.vue";

export default {
  name: "ArticleNew",

  components: { GeneralTemplate, ArticleEditContent },

  data() {
    return {
      toolbarTitle: "New Article",
      article: gon.article,
      currentUser: gon.currentUser,
      flashes: gon.flashJson
    };
  }
};
</script>
