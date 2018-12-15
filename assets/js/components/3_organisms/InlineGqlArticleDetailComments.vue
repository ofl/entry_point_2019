<template>
  <transition-group
    tag="div"
    id="comments"
    class="comment-list-card"
  >
    <ArticleComment
      v-for="(comment, index) in comments"
      :key="commentKey(comment.id)"
      :comment="comment"
      :currentUser="currentUser"
      @delete-comment="deleteComment"
    />
  </transition-group>
</template>

<script>
import ArticleComment from '../2_molecules/InlineGqlArticleComment.vue';

import ARTICLE_DETAIL_QUERY from '../../gqls/article.gql';
import DELETE_COMMENT_MUTATION from '../../gqls/destroyComment.gql';

export default {
  name: 'InlineGqlArticleDetailComments',

  components: {
    'ArticleComment': ArticleComment,
  },

  props: {
    articleId: {
      type: Number,
      required: true
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

    async deleteComment(id) {
      await this.$apollo.mutate({
        mutation: DELETE_COMMENT_MUTATION,
        variables: {
          id: id,
        },
        update: (store, { data: { destroyComment: { comment, article, errors } } }) => {
          const data = store.readQuery({ query: ARTICLE_DETAIL_QUERY, variables: {id: this.articleId} });

          const destroyedCommentId = parseInt(comment.id, 10)
          data.article.comments = data.article.comments.filter(cmnt => parseInt(cmnt.id, 10) !== destroyedCommentId);
          data.article.commentsCount = article.commentsCount

          store.writeQuery({ query: ARTICLE_DETAIL_QUERY, variables: {id: this.articleId}, data });
        }
      }).then((data) => {
        console.log(data)
      }).catch((error) => {
        // Error
        console.error(error)
      })
    },
  }
}
</script>

<style scoped>
.comment-list-card {
  margin-top: 50px;
}

.flex {
  display: flex;
}

.v-enter-active {
  transition: all .4s ease;
}

.v-leave-active {
  transition: all .4s cubic-bezier(1.0, 0.5, 0.8, 1.0);
}

.v-enter, .v-leave-to {
  transform: translateX(10px);
  opacity: 0;
}
</style>
