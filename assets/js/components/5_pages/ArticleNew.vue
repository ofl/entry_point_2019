<template>
  <div>
    <TheNavigation :current-user="currentUser" />
    <AppContent :article="article" />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from "../3_organisms/TheNavigation.vue";
import TheFooter from "../3_organisms/TheFooter.vue";
import AppContent from "../4_templates/ArticleEditContent.vue";

export default {
  name: "ArticleNew",

  components: {
    TheNavigation: TheNavigation,
    AppContent: AppContent,
    TheFooter: TheFooter
  },

  data() {
    return {
      toolbarTitle: "New Article",
      article: gon.article,
      currentUser: gon.currentUser
    };
  }
};
</script>
