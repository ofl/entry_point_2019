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
            <img :src="avatarUrl" alt="Avatar Image">
          </figure>
        </div>
        <div class="media-content">
          <p class="title is-4">{{ article.title }}</p>
          <p class="subtitle is-6">{{ article.user.name }}</p>
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
        <a href="#" class="card-footer-item" @click.stop.prevent="onClickEditBtn()">Edit</a>
        <a href="#" class="card-footer-item" @click.stop.prevent="onClickDeleteBtn()">Delete</a>
      </template>
    </footer>
  </div>
</template>

<script>
import TOGGLE_LIKE_MUTATION from "../../gqls/toggleFavorite.gql";

export default {
  name: "ArticleDetailCard",

  props: {
    article: {
      type: Object
    },
    currentUser: {
      type: Object
    }
  },

  data() {
    return {
      favoritesCount: 0,
      favedByMe: false
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
    avatarUrl() {
      return !!this.article.user.avatarUrl
        ? this.article.user.avatarUrl
        : "../images/300x300.png";
    }
  },

  mounted() {
    this.updateFavoriteStatus(
      this.article.favorites_count,
      this.article.faved_by_me
    );
  },

  methods: {
    onClickEditBtn() {
      location.pathname = `/vue_articles/${this.article.id}/edit`;
    },
    onClickDeleteBtn() {
      location.pathname = `/vue_articles/${this.article.id}/edit`;
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
            id: this.article.id
          }
        })
        .then(data => {
          // Result
          const article = data.data.articleToggleFavorite.article;
          this.updateFavoriteStatus(article.favoritesCount, article.favedByMe);
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
