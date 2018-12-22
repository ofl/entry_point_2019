<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <InlineGqlArticleListContent
      :articles="articles"
      :current-user="currentUser"
    />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../4_templates/GeneralTemplate.vue";
import InlineGqlArticleListContent from "../3_organisms/InlineGqlArticleListContent.vue";

import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "InlineGqlArticleList",

  components: { GeneralTemplate, InlineGqlArticleListContent },

  data() {
    return {
      toolbarTitle: "Inline+GQL Articles",
      currentUser: gon.currentUser,
      articles: gon.articles,
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
