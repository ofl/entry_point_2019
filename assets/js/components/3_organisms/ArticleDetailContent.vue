<template>
  <div class="container">
    <ArticleDetailCard :article="article"
:currentUser="currentUser" />
    <ArticleDetailComments
      :comments="article.comments"
      :current-user="currentUser"
    />
    <ArticleDetailCommentForm
      :current-user="currentUser"
      :article-id="article.id"
    />
  </div>
</template>

<script>
import ArticleDetailCard from "../3_organisms/ArticleDetailCard.vue";
import ArticleDetailComments from "../3_organisms/ArticleDetailComments.vue";
import ArticleDetailCommentForm from "../3_organisms/ArticleDetailCommentForm.vue";

export default {
  name: "ArticleDetailContent",

  components: {
    ArticleDetailCard,
    ArticleDetailComments,
    ArticleDetailCommentForm
  },

  props: {
    article: {
      type: Object
    },
    currentUser: {
      type: Object
    }
  }
};
</script>
