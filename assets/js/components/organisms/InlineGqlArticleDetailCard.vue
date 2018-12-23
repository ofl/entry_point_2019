<template>
  <div class="card">
    <div class="card-image">
      <figure class="image is-4by3">
        <img
          src="https://bulma.io/images/placeholders/1280x960.png"
          alt="Placeholder image"
        />
      </figure>
    </div>

    <div class="card-content">
      <div class="media">
        <div class="media-left">
          <figure class="image is-48x48">
            <img
              src="https://bulma.io/images/placeholders/96x96.png"
              alt="Placeholder image"
            />
          </figure>
        </div>
        <div class="media-content">
          <p class="title is-4">{{ article.title }}</p>
          <p class="subtitle is-6">{{ article.user.name }}</p>
        </div>
      </div>

      <div class="content">
        {{ article.body }} <br >
        <time datetime="article.createdAt"> {{ article.createdAt }} </time>
      </div>
    </div>
    <footer class="card-footer">
      <a
        href="#"
        class="card-footer-item"
        @click.stop.prevent="onClickLikeBtn()"
      >
        <span class="has-text-grey-light">
          <BIcon pack="fa"
icon="heart" :type="likedType" />
          {{ article.likesCount }}
        </span>
      </a>

      <template v-if="isOwner">
        <RouterLink
          :to="{ name: 'InlineGqlArticleEdit', params: { id: article.id } }"
          class="card-footer-item"
        >
          Edit
        </RouterLink>
        <a
          href="#"
          class="card-footer-item"
          @click.stop.prevent="onClickDeleteBtn()"
        >
          Delete
        </a>
      </template>
    </footer>
  </div>
</template>

<script>
import gql from "graphql-tag";
import DESTROY_ARTICLE_MUTATION from "../../gqls/destroyArticle.gql";
import ARTICLE_INDEX_QUERY from "../../gqls/articles.gql";

const ToggleLikeMutation = gql`
  mutation articleToggleLike($id: ID!) {
    articleToggleLike(input: { id: $id }) {
      article {
        id
        likesCount
        likedByMe
      }
    }
  }
`;

export default {
  name: "InlineGqlArticleDetailCard",

  props: {
    article: {
      type: Object
    },
    currentUser: {
      type: Object
    }
  },

  computed: {
    isLoggedIn() {
      return !!this.currentUser;
    },
    isOwner() {
      if (!this.isLoggedIn) {
        return false;
      }
      return parseInt(this.article.user.id, 10) == this.currentUser.id;
    },
    likedType() {
      return this.article.likedByMe ? "is-primary" : null;
    },
    articleId() {
      return this.article.id;
    }
  },

  methods: {
    onClickDeleteBtn() {
      this.$dialog.confirm({
        message: "Are you sure?",
        onConfirm: () => this.destroyArticle()
      });
    },
    onClickLikeBtn() {
      if (!this.isLoggedIn) {
        this.$dialog.alert("Please login!");
        return;
      }
      this.toggleLike();
    },

    async toggleLike() {
      await this.$apollo
        .mutate({
          mutation: ToggleLikeMutation,
          variables: {
            id: this.article.id
          }
        })
        .then(data => {
          // Result
          const article = data.data.articleToggleLike.article;
          // this.updateLikeStatus(article.likesCount, article.likedByMe);
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
    }
  }
};
</script>
