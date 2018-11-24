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
import ArticleDetailCard from '../../organisms/ArticleDetailCard.vue';
import ArticleDetailComments from '../../organisms/ArticleDetailComments.vue';
import ArticleDetailCommentForm from '../../organisms/ArticleDetailCommentForm.vue';
import TheFlashes from '../../organisms/TheFlashes.vue';

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
