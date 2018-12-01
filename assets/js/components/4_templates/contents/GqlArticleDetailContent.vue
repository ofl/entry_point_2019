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
        :articleId="articleId"
      />
    </div>
  </section>
</template>

<script>
import ArticleDetailCard from '../../3_organisms/GqlArticleDetailCard.vue';
import ArticleDetailComments from '../../3_organisms/ArticleDetailComments.vue';
import ArticleDetailCommentForm from '../../3_organisms/ArticleDetailCommentForm.vue';
import TheFlashes from '../../3_organisms/TheFlashes.vue';
import ArticleDetailQuery from '../../../gqls/article.gql';

export default {
  name: 'GqlArticleDetailContent',

  components: {
    'ArticleDetailCard': ArticleDetailCard,
    'ArticleDetailComments': ArticleDetailComments,
    'ArticleDetailCommentForm': ArticleDetailCommentForm,
    'TheFlashes': TheFlashes,
  },

  props: {
    articleId: {
      type: Number,
      required: true
    },
    currentUser: {
      type: Object
    },
    flashes: {
      type: Object
    }
  },

  data () {
    return {
      article: {
        id: 0,
        title: '',
        body: '',
        user: {
          id: '',
          name: '',
        },
        comments: [],
        commentsCount: 0,
        likesCount: 0,
        likedByMe: false
      },
    }
  },

  apollo: {
    article: {
      query: ArticleDetailQuery,
      variables() {
        return {
          id: this.articleId,
        }
      },
    }
  },
}
</script>
