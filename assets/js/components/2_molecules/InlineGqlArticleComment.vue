<template>
  <article class="media">
    <figure class="media-left">
      <p class="image is-48x48">
        <img
          :src="avatarUrl"
        >
      </p>
    </figure>
    <div class="media-content">
      <div class="content">
        <p>
          <strong>{{ comment.user.name }}</strong>
          <br>
          {{ comment.body }}
          <br>
          <small>
            <a
              @click.stop.prevent="handleClickDelete(comment.id)"
            >
              Delete
            </a>
             ·
            <a>Reply</a>
            {{ comment.createdAt }}
          </small>
        </p>
      </div>
    </div>
  </article>
</template>

<script>
export default {
  name: 'InlineGqlArticleComment',

  props: {
    comment: {
      type: Object
    }
  },

  computed: {
    avatarUrl () {
      return (this.comment.user.avatar != '') ? this.comment.user.avatar : "http://bulma.io/images/placeholders/128x128.png";
    },
  },

  methods: {
    handleClickDelete(id) {
      this.$emit('delete-comment', id)
    },
  }
}
</script>
