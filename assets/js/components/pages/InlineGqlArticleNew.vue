<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <InlineGqlArticleEditForm />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import InlineGqlArticleEditForm from "../organisms/InlineGqlArticleEditForm.vue";

import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "ArticleNew",

  components: { GeneralTemplate, InlineGqlArticleEditForm },

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
