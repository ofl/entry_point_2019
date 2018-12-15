<template>
  <div>
    <TheNavigation :current-user="currentUser" />
    <AppContent
      :current-user="currentUser"
      :articles="articles"
      :flashes="flashes"
    />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from "../4_templates/TheNavigation.vue";
import TheFooter from "../4_templates/TheFooter.vue";
import AppContent from "../4_templates/contents/SpaPagedArticleListContent.vue";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "SpaArticleList",

  components: {
    TheNavigation: TheNavigation,
    AppContent: AppContent,
    TheFooter: TheFooter
  },

  data() {
    return {
      toolbarTitle: "Spa Articles",
      articles: [],
      currentUser: null,
      flashes: {}
    };
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY
    }
  }
};
</script>
