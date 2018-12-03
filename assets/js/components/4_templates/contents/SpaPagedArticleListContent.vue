<template>
  <section class="section main-contents">
    <TheFlashes :flashes="flashes" />

    <div class="container">
      <div class="box content" v-if="pagedArticles">
        <ArticleListItem
          v-for="(article, index) in pagedArticles.articles"
          :key="articleKey(article.id)"
          :article="article"
        />
      </div>

      <div class="new-button">
        <button
          v-if="showMoreEnabled"
          class="button field is-info"
          @click="onClickNewBtn()"
        >
          <b-icon icon="more"></b-icon>
          <span>Show More</span>
        </button>

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
import ArticleListItem from '../../2_molecules/SpaArticleListItem.vue';
import PAGED_ARTICLE_INDEX_QUERY from '../../../gqls/pagedArticles.gql';

const pageSize = 10;

export default {
  name: 'SpaPagedArticleListContent',

  components: {
    'ArticleListTable': ArticleListTable,
    'ArticleListItem': ArticleListItem,
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
      page: 1,
      showMoreEnabled: true,
    }
  },

  methods: {
    onClickNewBtn () {
      location.href = '/vue_articles/new';
    },
    articleKey(id) {
      return `article-${id}`;
    },
  },

  apollo: {
    pagedArticles: {
      query: PAGED_ARTICLE_INDEX_QUERY,
      variables: {
        page: 1,
        pageSize,
      },
    }
  },
}
</script>
