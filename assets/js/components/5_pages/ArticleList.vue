<template>
  <div>
    <TheNavigation :current-user="currentUser" />
    <AppContent :articles="articles"
:flashes="flashes" />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from "../3_organisms/TheNavigation.vue";
import TheFooter from "../3_organisms/TheFooter.vue";
import AppContent from "../4_templates/ArticleListContent.vue";

export default {
  name: "ArticleList",

  components: {
    TheNavigation: TheNavigation,
    AppContent: AppContent,
    TheFooter: TheFooter
  },

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
