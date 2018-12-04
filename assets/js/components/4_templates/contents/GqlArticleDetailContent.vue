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
        v-if="isLoggedIn"
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
import ARTICLE_DETAIL_QUERY from '../../../gqls/article.gql';

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
      type: String,
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

  computed: {
    isLoggedIn () {
      return !!this.currentUser
    },
  },

  apollo: {
    article: {
      query: ARTICLE_DETAIL_QUERY,
      variables() {
        return {
          id: this.articleId,
        }
      },
    }
  },
}
</script>
