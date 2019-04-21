<template>
  <TransitionGroup id="comments"
tag="div" class="comment-list-card">
    <ArticleComment
      v-for="(comment, index) in comments"
      :key="commentKey(comment.id)"
      :comment="comment"
      :articleId="articleId"
      :current-user="currentUser"
      :need-force-update="needForceUpdate"
      @reloadArticle="reloadArticle"
      @delete-comment="deleteComment"
    />
  </TransitionGroup>
</template>

<script>
import ArticleComment from "../molecules/InlineGqlArticleComment.vue";

import ARTICLE_DETAIL_QUERY from "../../gqls/article.gql";
import DELETE_COMMENT_MUTATION from "../../gqls/destroyComment.gql";

export default {
  name: "InlineGqlArticleDetailComments",

  components: {
    ArticleComment: ArticleComment
  },

  props: {
    articleId: {
      type: String,
      required: true
    },

    needForceUpdate: {
      type: Boolean,
      default: false
    },

    comments: {
      type: Array,
      default: []
    },

    currentUser: {
      type: Object
    }
  },

  methods: {
    commentKey(id) {
      return `comment-${id}`;
    },

    reloadArticle() {
      this.$emit("reloadArticle");
    },

    async deleteComment(id) {
      await this.$apollo
        .mutate({
          mutation: DELETE_COMMENT_MUTATION,
          variables: {
            id: id
          },
          update: (
            store,
            {
              data: {
                destroyComment: { comment, article, errors }
              }
            }
          ) => {
            const data = store.readQuery({
              query: ARTICLE_DETAIL_QUERY,
              variables: { id: this.articleId }
            });

            const destroyedCommentId = comment.id;
            data.article.comments = data.article.comments.filter(
              cmnt => cmnt.id !== destroyedCommentId
            );
            data.article.commentsCount = article.commentsCount;

            store.writeQuery({
              query: ARTICLE_DETAIL_QUERY,
              variables: { id: this.articleId },
              data
            });
          }
        })
        .then(data => {
          console.log(data);
        })
        .catch(error => {
          // Error
          console.error(error);
        });
    }
  }
};
</script>

<style scoped>
.comment-list-card {
  margin-top: 50px;
}

.flex {
  display: flex;
}

.v-enter-active {
  transition: all 0.4s ease;
}

.v-leave-active {
  transition: all 0.4s cubic-bezier(1, 0.5, 0.8, 1);
}

.v-enter,
.v-leave-to {
  transform: translateX(10px);
  opacity: 0;
}
</style>
