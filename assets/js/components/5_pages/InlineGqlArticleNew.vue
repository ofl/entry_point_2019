<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <InlineGqlArticleNewContent :current-user="currentUser" />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../4_templates/GeneralTemplate.vue";
import InlineGqlArticleNewContent from "../3_organisms/InlineGqlArticleNewContent.vue";

import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "ArticleNew",

  components: { GeneralTemplate, InlineGqlArticleNewContent },

  data() {
    return {
      toolbarTitle: "New Article",
      currentUser: gon.currentUser,
      flashes: gon.flashes
    };
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
