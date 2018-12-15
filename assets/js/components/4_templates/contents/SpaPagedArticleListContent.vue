<template>
  <section class="section main-contents">
    <TheFlashes :flashes="flashes" />

    <div class="container">
      <div v-if="pagedArticles" class="box content">
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
          @click="showMore"
        >
          <BIcon icon="more" />
          <span>Show More</span>
        </button>

        <button class="button field is-info"
@click="onClickNewBtn()">
          <BIcon icon="pencil" />
          <span>New</span>
        </button>
      </div>
    </div>
  </section>
</template>

<script>
import ArticleListTable from "../../3_organisms/SpaArticleListTable.vue";
import TheFlashes from "../../3_organisms/TheFlashes.vue";
import ArticleListItem from "../../2_molecules/SpaArticleListItem.vue";
import PAGED_ARTICLE_INDEX_QUERY from "../../../gqls/pagedArticles.gql";

const pageSize = 10;

export default {
  name: "SpaPagedArticleListContent",

  components: {
    ArticleListTable: ArticleListTable,
    ArticleListItem: ArticleListItem,
    TheFlashes: TheFlashes
  },

  props: {
    flashes: {
      type: Object
    }
  },

  data() {
    return {
      articles: [],
      page: 1,
      showMoreEnabled: true
    };
  },

  apollo: {
    pagedArticles: {
      query: PAGED_ARTICLE_INDEX_QUERY,
      variables: {
        page: 1,
        pageSize
      }
    }
  },

  methods: {
    onClickNewBtn() {
      location.href = "/vue_articles/new";
    },
    articleKey(id) {
      return `article-${id}`;
    },

    // https://akryum.github.io/vue-apollo/guide/apollo/pagination.html
    showMore() {
      this.page++;
      // Fetch more data and transform the original result
      this.$apollo.queries.pagedArticles.fetchMore({
        // New variables
        variables: {
          page: this.page,
          pageSize
        },
        // Transform the previous result with new data
        updateQuery: (previousResult, { fetchMoreResult }) => {
          const newArticles = fetchMoreResult.pagedArticles.articles;
          const hasMore = fetchMoreResult.pagedArticles.hasMore;

          this.showMoreEnabled = hasMore;

          return {
            pagedArticles: {
              __typename: previousResult.pagedArticles.__typename,
              // Merging the tag list
              articles: [
                ...previousResult.pagedArticles.articles,
                ...newArticles
              ],
              hasMore
            }
          };
        }
      });
    }
  }
};
</script>
