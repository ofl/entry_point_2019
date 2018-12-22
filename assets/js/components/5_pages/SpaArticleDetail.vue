<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <GqlArticleDetailContent
      :article-id="articleId"
      :current-user="currentUser"
    />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../4_templates/GeneralTemplate.vue";
import GqlArticleDetailContent from "../3_organisms/GqlArticleDetailContent.vue";

import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "SpaArticleDetail",

  components: { GeneralTemplate, GqlArticleDetailContent },

  data() {
    return {
      toolbarTitle: "Article",
      // currentUser: gon.currentUser,
      currentUser: null,
      flashes: {}
    };
  },

  computed: {
    articleId() {
      return parseInt(this.$route.params.id, 10);
    }
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY
    }
  }
};
</script>
