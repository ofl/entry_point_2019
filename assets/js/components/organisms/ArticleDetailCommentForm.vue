<template>
  <article class="media comment-form">
    <figure class="media-left">
      <p class="image is-64x64">
        <img :src="avatarUrl">
      </p>
    </figure>

    <CommentForm :comment="comment" :serverErrors="serverErrors" @mutateComment="addComment"/>
  </article>
</template>

<script>
import CommentForm from "../molecules/CommentForm.vue";

import ARTICLE_DETAIL_QUERY from "../../gqls/article.gql";
import ADD_COMMENT_MUTATION from "../../gqls/addComment.gql";

export default {
  name: "ArticleDetailCommentForm",

  components: { CommentForm },

  props: {
    currentUser: {
      type: Object
    },
    articleId: {
      type: String,
      required: true
    },
    hasInlineArticleData: {
      type: Boolean,
      default: false
    }
  },

  computed: {
    avatarUrl() {
      return this.currentUser.avatarUrl != ""
        ? this.currentUser.avatarUrl
        : "../images/300x300.png";
    }
  },

  data() {
    return {
      comment: { body: "" },
      serverErrors: []
    };
  },

  methods: {
    async addComment(body) {
      await this.$apollo
        .mutate({
          mutation: ADD_COMMENT_MUTATION,
          variables: {
            articleId: this.articleId,
            attributes: {
              body: body
            }
          },
          update: (store, { data: { createComment } }) => {
            if (createComment.errors.length > 0) {
              this.serverErrors = createComment.errors;
              return;
            }

            const data = store.readQuery({
              query: ARTICLE_DETAIL_QUERY,
              variables: { id: this.articleId }
            });
            data.article.comments.push(createComment.comment);
            data.article.commentsCount = createComment.article.commentsCount;

            store.writeQuery({
              query: ARTICLE_DETAIL_QUERY,
              variables: { id: this.articleId },
              data
            });
            this.comment = { body: "" };

            if (this.hasInlineArticleData) {
              this.$emit("reloadArticle");
            }
          }
        })
        .then(data => {
          console.log(data);
        })
        .catch(error => {
          console.error(error);
        });
    }
  }
};
</script>

<style scoped>
.comment-form {
  margin-top: 50px;
}
</style>
