<template>
  <section class="section main-contents">
    <TheFlashes :flashes="flashes" />

    <div class="container">
      <ArticleDetailCard
        v-if="article"
        :article="article"
        :currentUser="currentUser"
      />
      <ArticleDetailComments
        v-if="article"
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
  name: 'InlineGqlArticleDetailContent',

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
      article: gon.article,
    }
  },

  computed: {
    isLoggedIn () {
      return !!this.currentUser
    },
    hasInlineData () {
      return !!gon.article;
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
      skip() {
        return this.hasInlineData;
      },
    }
  },

  mounted () {
    console.log(666666666);
    if (this.hasInlineData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: ARTICLE_DETAIL_QUERY,
        data: { article: gon.article }
      });
      // 別の記事詳細を表示した時にgon.articleを表示しないようにnullにする。
      gon.article = null;
    }
  },
}
</script>
