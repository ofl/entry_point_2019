<template>
  <div class="container">
    <ArticleDetailCard :article="article"
:currentUser="currentUser" />
    <ArticleDetailComments
      :comments="article.comments"
      :current-user="currentUser"
    />
    <ArticleDetailCommentForm
      v-if="isLoggedIn"
      :current-user="currentUser"
      :article-id="articleId"
    />
  </div>
</template>

<script>
import ArticleDetailCard from "../3_organisms/GqlArticleDetailCard.vue";
import ArticleDetailComments from "../3_organisms/ArticleDetailComments.vue";
import ArticleDetailCommentForm from "../3_organisms/ArticleDetailCommentForm.vue";

import ARTICLE_DETAIL_QUERY from "../../gqls/article.gql";

export default {
  name: "GqlArticleDetailContent",

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
      article: {
        id: 0,
        title: "",
        body: "",
        user: {
          id: "",
          name: ""
        },
        comments: [],
        commentsCount: 0,
        likesCount: 0,
        likedByMe: false
      }
    };
  },

  computed: {
    isLoggedIn() {
      return !!this.currentUser;
    }
  },

  apollo: {
    article: {
      query: ARTICLE_DETAIL_QUERY,
      variables() {
        return {
          id: this.articleId
        };
      }
    }
  }
};
</script>
