<template>
  <div>
    <TheNavigation :current-user="currentUser" />
    <AppContent
      :article-id="article.id"
      :current-user="currentUser"
      :flashes="flashes"
    />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from "../3_organisms/TheNavigation.vue";
import TheFooter from "../3_organisms/TheFooter.vue";
// import AppContent from '../4_templates/ArticleDetailContent.vue';
import AppContent from "../4_templates/GqlArticleDetailContent.vue";

export default {
  name: "ArticleDetail",

  components: {
    TheNavigation: TheNavigation,
    AppContent: AppContent,
    TheFooter: TheFooter
  },

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
