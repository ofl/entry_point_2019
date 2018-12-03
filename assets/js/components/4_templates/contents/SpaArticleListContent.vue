<template>
  <section class="section main-contents">
    <TheFlashes :flashes="flashes" />

    <div class="container">
      <ArticleListTable
        :articles="articles"
      />

      <div class="new-button">
        <button
          class="button field is-info"
          @click="onClickNewBtn()"
        >
          <b-icon icon="pencil"></b-icon>
          <span>New</span>
        </button>
      </div>
    </div>
  </section class="section">
</template>

<script>
import ArticleListTable from '../../3_organisms/SpaArticleListTable.vue';
import TheFlashes from '../../3_organisms/TheFlashes.vue';
import ARTICLE_INDEX_QUERY from '../../../gqls/articles.gql';

export default {
  name: 'ArticleListContent',

  components: {
    'ArticleListTable': ArticleListTable,
    'TheFlashes': TheFlashes,
  },

  props: {
    flashes: {
      type: Object
    }
  },

  data () {
    return {
      articles: [],
    }
  },

  methods: {
    onClickNewBtn () {
      location.href = '/vue_articles/new';
    },
  },

  apollo: {
    articles: {
      query: ARTICLE_INDEX_QUERY,
    }
  },
}
</script>
