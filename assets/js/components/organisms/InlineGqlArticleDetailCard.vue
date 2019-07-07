<template>
  <div class="card">
    <div class="card-image">
      <figure class="image is-4by3">
        <img src="https://bulma.io/images/placeholders/1280x960.png" alt="Placeholder image">
      </figure>
    </div>

    <div class="card-content">
      <div class="media">
        <div class="media-left">
          <figure class="image is-48x48">
            <img :src="avatarUrl" alt="Avatar image">
          </figure>
        </div>
        <div class="media-content">
          <p class="title is-4">{{ article.title }}</p>
          <p class="subtitle is-6">
            <RouterLink
              :to="{ name: 'User', params: { name: article.user.name } }"
            >{{ article.user.name }}</RouterLink>
          </p>
        </div>
      </div>

      <div class="content">
        {{ article.body }}
        <br>
        <time datetime="article.createdAt">{{ article.createdAt }}</time>
      </div>
    </div>
    <footer class="card-footer">
      <a href="#" class="card-footer-item" @click.stop.prevent="onClickFavoriteBtn()">
        <span class="has-text-grey-light">
          <BIcon pack="fa" icon="heart" :type="favoriteType"/>
          {{ favoritesCount }}
        </span>
      </a>

      <template v-if="isOwner">
        <RouterLink
          :to="{ name: 'InlineGqlArticleEdit', params: { id: article.id } }"
          class="card-footer-item"
        >Edit</RouterLink>
        <a href="#" class="card-footer-item" @click.stop.prevent="onClickDeleteBtn()">Delete</a>
      </template>
    </footer>
  </div>
</template>

<script>
import DESTROY_ARTICLE_MUTATION from "../../gqls/destroyArticle.gql";
import ARTICLE_INDEX_QUERY from "../../gqls/articles.gql";
import TOGGLE_LIKE_MUTATION from "../../gqls/toggleFavorite.gql";
import ARTICLE_DETAIL_QUERY from "../../gqls/article.gql";

export default {
  name: "InlineGqlArticleDetailCard",

  props: {
    article: {
      type: Object,
      required: true
    },
    currentUser: {
      type: Object
    }
  },

  data() {
    return {
      favoritesCount: this.article.favoritesCount,
      favedByMe: this.article.favedByMe
    };
  },

  computed: {
    isLoggedIn() {
      return !!this.currentUser;
    },
    isOwner() {
      if (!this.isLoggedIn) {
        return false;
      }
      return this.article.user.id == this.currentUser.id;
    },
    favoriteType() {
      return this.favedByMe ? "is-primary" : null;
    },
    articleId() {
      return this.article.id;
    },
    avatarUrl() {
      return !!this.article.user.avatarUrl
        ? this.article.user.avatarUrl
        : "../images/300x300.png";
    }
  },

  methods: {
    onClickDeleteBtn() {
      this.$dialog.confirm({
        message: "Are you sure?",
        onConfirm: () => this.destroyArticle()
      });
    },
    onClickFavoriteBtn() {
      if (!this.isLoggedIn) {
        this.$dialog.alert("Please login!");
        return;
      }
      this.toggleFavorite();
    },

    async toggleFavorite() {
      await this.$apollo
        .mutate({
          mutation: TOGGLE_LIKE_MUTATION,
          variables: {
            id: this.articleId
          },
          update: (store, { data: { articleToggleFavorite } }) => {
            const favoritesCount = articleToggleFavorite.article.favoritesCount;
            const favedByMe = articleToggleFavorite.article.favedByMe;

            this.updateFavoriteStatus(favoritesCount, favedByMe);

            const data = store.readQuery({
              query: ARTICLE_DETAIL_QUERY,
              variables: { id: this.articleId }
            });

            data.article.favedByMe = favedByMe;
            data.article.favoritesCount = favoritesCount;

            store.writeQuery({
              query: ARTICLE_DETAIL_QUERY,
              variables: { id: data.article.id },
              data
            });
          }
        })
        .then(data => {
          // Result
          const article = data.data.articleToggleFavorite.article;
        })
        .catch(error => {
          // Error
          console.error(error);
        });
    },

    async destroyArticle() {
      await this.$apollo
        .mutate({
          mutation: DESTROY_ARTICLE_MUTATION,
          variables: {
            id: this.articleId
          },
          update: (store, { data: { destroyArticle } }) => {
            const data = store.readQuery({ query: ARTICLE_INDEX_QUERY });
            const destroydArticleId = destroyArticle.article.id;
            data.articles = data.articles.filter(
              article => article.id !== destroydArticleId
            );

            store.writeQuery({ query: ARTICLE_INDEX_QUERY, data });
          }
        })
        .then(data => {
          // 一覧にリダイレクトする
          // this.$router.push({ path: '/inline_gql_articles' })
        })
        .catch(error => {
          // Error
          console.error(error);
        });
    },

    updateFavoriteStatus(favoritesCount, favedByMe) {
      this.favoritesCount = favoritesCount;
      this.favedByMe = favedByMe;
    }
  }
};
</script>
