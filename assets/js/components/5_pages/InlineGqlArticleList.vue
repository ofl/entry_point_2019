<template>
  <div>
    <TheNavigation :current-user="currentUser" />
    <AppContent :current-user="currentUser"
:flashes="flashes" />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from "../3_organisms/TheNavigation.vue";
import TheFooter from "../3_organisms/TheFooter.vue";
import AppContent from "../4_templates/InlineGqlArticleListContent.vue";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "InlineGqlArticleList",

  components: {
    TheNavigation: TheNavigation,
    AppContent: AppContent,
    TheFooter: TheFooter
  },

  data() {
    return {
      toolbarTitle: "Inline+GQL Articles",
      currentUser: gon.currentUser,
      flashes: gon.flashJson
    };
  },

  computed: {
    hasInlineData() {
      return !!gon.currentUser;
    }
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY,
      skip() {
        return this.hasInlineData;
      }
    }
  },

  mounted() {
    if (this.hasInlineData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: CURRENT_USER_QUERY,
        data: { currentUser: gon.currentUser }
      });
    }
  }
};
</script>
