<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <InlineGqlArticleDetailContent
      :article="article"
      :article-id="articleId"
      :current-user="currentUser"
    />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import InlineGqlArticleDetailContent from "../organisms/InlineGqlArticleDetailContent.vue";

import ARTICLE_DETAIL_QUERY from "../../gqls/article.gql";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

import SetTitleMixin from "../../utils/setTitle";

export default {
  name: "InlineGqlArticleDetail",

  components: { GeneralTemplate, InlineGqlArticleDetailContent },

  data() {
    return {
      toolbarTitle: "Article",
      currentUser: gon.currentUser,
      article: gon.article,
      flashes: {}
    };
  },

  computed: {
    articleId() {
      return this.$route.params.id;
    },
    hasInlineUserData() {
      return !!gon.currentUser;
    },
    hasInlineArticleData() {
      return !!gon.article;
    }
  },

  watch: {
    article: function (val) {
      document.title = `${val.title} | EP2019`;
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
      query: ARTICLE_DETAIL_QUERY,
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
    // Gonからデータを取得した場合、Apollo client キャッシュへの書き込む

    if (this.hasInlineUserData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: CURRENT_USER_QUERY,
        data: { currentUser: gon.currentUser }
      });
    }

    if (this.hasInlineArticleData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: ARTICLE_DETAIL_QUERY,
        variables: { id: this.articleId },
        data: { article: gon.article }
      });
      // 別の記事詳細を表示した時にgon.articleを表示しないようにnullにする。
      gon.article = null;
    }
  }
};
</script>
