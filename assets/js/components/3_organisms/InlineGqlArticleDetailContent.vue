<template>
  <div class="container">
    <ArticleDetailCard
      v-if="article"
      :article="article"
      :current-user="currentUser"
    />
    <ArticleDetailComments
      v-if="article"
      :comments="article.comments"
      :current-user="currentUser"
      :article-id="articleId"
    />
    <ArticleDetailCommentForm
      v-if="isLoggedIn"
      :current-user="currentUser"
      :article-id="articleId"
    />
  </div>
</template>

<script>
import ArticleDetailCard from "../3_organisms/InlineGqlArticleDetailCard.vue";
import ArticleDetailComments from "../3_organisms/InlineGqlArticleDetailComments.vue";
import ArticleDetailCommentForm from "../3_organisms/ArticleDetailCommentForm.vue";

import ARTICLE_DETAIL_QUERY from "../../gqls/article.gql";

export default {
  name: "InlineGqlArticleDetailContent",

  components: {
    ArticleDetailCard,
    ArticleDetailComments,
    ArticleDetailCommentForm
  },

  props: {
    articleId: {
      type: Number,
      required: true
    },
    currentUser: {
      type: Object
    }
  },

  data() {
    return {
      article: gon.article
    };
  },

  computed: {
    isLoggedIn() {
      return !!this.currentUser;
    },
    hasInlineData() {
      return !!gon.article;
    }
  },

  apollo: {
    article: {
      query: ARTICLE_DETAIL_QUERY,
      variables() {
        return {
          id: this.articleId
        };
      },
      skip() {
        return this.hasInlineData;
      }
    }
  },

  mounted() {
    if (this.hasInlineData) {
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
