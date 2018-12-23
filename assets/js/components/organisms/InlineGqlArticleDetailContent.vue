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
import ArticleDetailCard from "../organisms/InlineGqlArticleDetailCard.vue";
import ArticleDetailComments from "../organisms/InlineGqlArticleDetailComments.vue";
import ArticleDetailCommentForm from "../organisms/ArticleDetailCommentForm.vue";

export default {
  name: "InlineGqlArticleDetailContent",

  components: {
    ArticleDetailCard,
    ArticleDetailComments,
    ArticleDetailCommentForm
  },

  props: {
    article: {
      type: Object,
      default() {
        return {
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
        };
      }
    },
    articleId: {
      type: String,
      required: true
    },
    currentUser: {
      type: Object
    }
  },

  computed: {
    isLoggedIn() {
      return !!this.currentUser;
    }
  }
};
</script>
