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
          <p class="title is-4">{{ article.user.name }}</p>
          <p class="subtitle is-6">{{ article.user.name }}</p>
        </div>
      </div>

      <div class="content">
        {{ article.body }}
        <br>
        <time datetime="article.created_at">{{ article.created_at }}</time>
      </div>
    </div>
    <footer class="card-footer">
      <a
        @click.stop.prevent="onClickLikeBtn()"
        href="#"
        class="card-footer-item"
      >
        <span class="has-text-grey-light"><i class="fa fa-heart"></i> {{ article.likes_count }}</span>
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
export default {
  name: 'ArticleDetailCard',

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
      return this.article.user_id == this.currentUser.id;
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
      console.log(88888888);
    },
  }
}
</script>
