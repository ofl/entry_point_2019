<template>
  <div id="comments"
class="comment-list-card">
    <ArticleComment
      v-for="(comment, index) in comments"
      :key="commentKey(comment.id)"
      :comment="comment"
    />
  </div>
</template>

<script>
import ArticleComment from "../molecules/ArticleComment.vue";

export default {
  name: "ArticleDetailComments",

  components: { ArticleComment },

  props: {
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
    }
  }
};
</script>

<style scoped>
.comment-list-card {
  margin-top: 50px;
}
</style>
