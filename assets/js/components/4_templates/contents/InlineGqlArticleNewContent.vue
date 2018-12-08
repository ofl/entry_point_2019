<template>
  <section class="section main-contents">
    <TheFlashes :flashes="flashes" />

    <div class="container">
      <ArticleNewForm
        v-if="article"
        :article="article"
      />
    </div>
  </section>
</template>

<script>
import ArticleNewForm from '../../3_organisms/InlineGqlArticleEditForm.vue';
import TheFlashes from '../../3_organisms/TheFlashes.vue';

export default {
  name: 'InlineGqlArticleNewContent',

  components: {
    'ArticleNewForm': ArticleNewForm,
    'TheFlashes': TheFlashes,
  },

  props: {
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

  mounted () {
    if (this.hasInlineData) {
      // 別の記事詳細を表示した時にgon.articleを表示しないようにnullにする。
      gon.article = null;
    } else {
      this.article = {
        title: '',
        body: '',
      }
    }
  },
}
</script>
