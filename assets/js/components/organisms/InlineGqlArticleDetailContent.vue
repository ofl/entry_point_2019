<template>
  <div class="container">
    <ArticleDetailCard v-if="article" :article="article" :current-user="currentUser"/>
    <ArticleDetailComments
      v-if="article"
      :comments="article.comments"
      :current-user="currentUser"
      :article-id="articleId"
      :need-force-update="hasInlineArticleData"
      @reloadArticle="reloadArticle"
    />
    <ArticleDetailCommentForm
      v-if="isLoggedIn"
      :current-user="currentUser"
      :article-id="articleId"
      :need-force-update="hasInlineArticleData"
      @reloadArticle="reloadArticle"
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
    },
    hasInlineArticleData: {
      type: Boolean,
      default: false
    }
  },

  computed: {
    isLoggedIn() {
      return !!this.currentUser;
    }
  },

  methods: {
    reloadArticle() {
      this.$emit("reloadArticle");
    }
  }
};
</script>
