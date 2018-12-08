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
            <img src="https://bulma.io/images/placeholders/96x96.png" alt="Placeholder image">
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
      <a
        @click.stop.prevent="onClickLikeBtn()"
        href="#"
        class="card-footer-item"
      >
        <span class="has-text-grey-light">
          <b-icon
            pack="fa"
            icon="heart"
            :type="likedType"
          >
          </b-icon>
           {{ article.likesCount }}
        </span>
      </a>

      <template v-if="isOwner">
        <a
          @click.stop.prevent="onClickEditBtn()"
          href="#"
          class="card-footer-item"
        >
          Edit
        </a>
        <a
          @click.stop.prevent="onClickDeleteBtn()"
          href="#"
          class="card-footer-item"
        >
          Delete
        </a>
      </template>
    </footer>
  </div>
</template>

<script>
import gql from 'graphql-tag';

const ToggleLikeMutation = gql`
  mutation articleToggleLike($id:ID!) {
    articleToggleLike(input: {id:$id}) {
      article {
        id
        likesCount
        likedByMe
      }
    }
  }
`;

export default {
  name: 'InlineGqlArticleDetailCard',

  props: {
    article: {
      type: Object
    },
    currentUser: {
      type: Object
    }
  },

  computed: {
    isLoggedIn () {
      return !!this.currentUser
    },
    isOwner () {
      if (!this.isLoggedIn) {
        return false;
      }
      return parseInt(this.article.user.id, 10) == this.currentUser.id;
    },
    likedType () {
      return this.article.likedByMe ? 'is-primary' : null;
    }
  },

  methods: {
    onClickEditBtn () {
      location.pathname = `/vue_articles/${this.article.id}/edit`;
    },
    onClickDeleteBtn () {
      location.pathname = `/vue_articles/${this.article.id}/edit`;
    },
    onClickLikeBtn () {
      if (!this.isLoggedIn) {
        this.$dialog.alert('Please login!')
        return;
      }
      this.toggleLike();
    },

    async toggleLike () {
      await this.$apollo.mutate({
        mutation: ToggleLikeMutation,
        variables: {
          id: this.article.id
        },
      }).then((data) => {
        // Result
        const article = data.data.articleToggleLike.article;
        // this.updateLikeStatus(article.likesCount, article.likedByMe);
      }).catch((error) => {
        // Error
        console.error(error);
      })
    },
  }
}
</script>
