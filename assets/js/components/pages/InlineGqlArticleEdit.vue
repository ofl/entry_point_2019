<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <InlineGqlArticleEditForm :article="article" />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import InlineGqlArticleEditForm from "../organisms/InlineGqlArticleEditForm.vue";

import ARTICLE_EDIT_QUERY from "../../gqls/articleEdit.gql";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "ArticleEdit",

  components: { GeneralTemplate, InlineGqlArticleEditForm },

  data() {
    return {
      toolbarTitle: "Edit Article",
      currentUser: gon.currentUser,
      article: gon.article,
      flashes: gon.flashes
    };
  },

  computed: {
    articleId() {
      return parseInt(this.$route.params.id, 10);
    },
    hasInlineUserData() {
      return !!gon.currentUser;
    },
    hasInlineArticleData() {
      return !!gon.article;
    }
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY,
      skip() {
        return this.hasInlineUserData;
      }
    },
    article: {
      query: ARTICLE_EDIT_QUERY,
      variables() {
        return {
          id: this.articleId
        };
      },
      skip() {
        return this.hasInlineArticleData;
      }
    }
  },

  mounted() {
    if (this.hasInlineUserData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: CURRENT_USER_QUERY,
        data: { currentUser: gon.currentUser }
      });
    }
    if (this.hasInlineArticleData) {
      // 別の記事詳細を表示した時にgon.articleを表示しないようにnullにする。
      gon.article = null;
    }
  }
};
</script>
