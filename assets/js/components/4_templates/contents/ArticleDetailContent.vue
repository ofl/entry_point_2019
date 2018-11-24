<template>
  <section class="section main-contents">
    <TheFlashes :flashes="flashes" />

    <div class="container">
      <ArticleDetailCard
        :article="article"
        :currentUser="currentUser"
      />
      <ArticleDetailComments
        :comments="article.comments"
        :currentUser="currentUser"
      />
      <ArticleDetailCommentForm
        :currentUser="currentUser"
        :articleId="article.id"
      />
    </div>
  </section>
</template>

<script>
import ArticleDetailCard from '../../3_organisms/ArticleDetailCard.vue';
import ArticleDetailComments from '../../3_organisms/ArticleDetailComments.vue';
import ArticleDetailCommentForm from '../../3_organisms/ArticleDetailCommentForm.vue';
import TheFlashes from '../../3_organisms/TheFlashes.vue';

export default {
  name: 'ArticleDetailContent',

  components: {
    'ArticleDetailCard': ArticleDetailCard,
    'ArticleDetailComments': ArticleDetailComments,
    'ArticleDetailCommentForm': ArticleDetailCommentForm,
    'TheFlashes': TheFlashes,
  },

  props: {
    article: {
      type: Object
    },
    currentUser: {
      type: Object
    },
    flashes: {
      type: Object
    }
  }
}
</script>
