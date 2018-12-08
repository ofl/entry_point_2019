<template>
  <section class="section main-contents">
    <TheFlashes :flashes="flashes" />

    <div class="container">
      <ArticleEditForm
        v-if="article"
        :article="article"
      />
    </div>
  </section>
</template>

<script>
import ArticleEditForm from '../../3_organisms/InlineGqlArticleEditForm.vue';
import TheFlashes from '../../3_organisms/TheFlashes.vue';
import ARTICLE_EDIT_QUERY from '../../../gqls/articleEdit.gql';

export default {
  name: 'InlineGqlArticleEditContent',

  components: {
    'ArticleEditForm': ArticleEditForm,
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
      query: ARTICLE_EDIT_QUERY,
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
    if (this.hasInlineData) {
      // 別の記事詳細を表示した時にgon.articleを表示しないようにnullにする。
      gon.article = null;
    }
  },
}
</script>
