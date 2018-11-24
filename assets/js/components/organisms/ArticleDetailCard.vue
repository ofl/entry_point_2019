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
    <footer
      v-if=isOwner
      class="card-footer"
    >
      <a
        @click="onClickEditBtn()"
        href="#"
        class="card-footer-item"
      >
        Edit
      </a>
      <a
        @click="onClickDeleteBtn()"
        href="#"
        class="card-footer-item"
      >
        Delete
      </a>
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
    isOwner () {
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
  }
}
</script>
