<template>
  <div class="comment-list-card">
    <ArticleComment
      v-for="(comment, index) in comments"
      :key="commentKey(comment.id)"
      :comment="comment"
    />
  </div>
</template>

<script>
import ArticleComment from '../2_molecules/ArticleComment.vue';

export default {
  name: 'ArticleDetailComments',

  components: {
    'ArticleComment': ArticleComment,
  },

  props: {
    comments: {
      type: Array
    },
    currentUser: {
      type: Object
    }
  },

  methods: {
    commentKey(id) {
      return `comment-${id}`;
    },
  }
}
</script>

<style scoped>
.comment-list-card {
  margin-top: 50px;
}
</style>
