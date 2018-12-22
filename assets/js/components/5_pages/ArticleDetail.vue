<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <ArticleDetailContent :article="article"
:current-user="currentUser" />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../4_templates/GeneralTemplate.vue";
import ArticleDetailContent from "../3_organisms/ArticleDetailContent.vue";

export default {
  name: "ArticleDetail",

  components: { GeneralTemplate, ArticleDetailContent },

  data() {
    return {
      toolbarTitle: "Article",
      article: gon.article,
      currentUser: gon.currentUser,
      flashes: gon.flashJson
    };
  }
};
</script>
