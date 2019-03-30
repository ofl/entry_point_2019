<template>
  <article class="media">
    <figure class="media-left">
      <p class="image is-48x48"><img :src="avatarUrl" />
</p>
    </figure>
    <div class="media-content">
      <div class="content">
        <p>
          <strong>{{ comment.user.name }}</strong> <br >
          {{ comment.body }} <br >
          <small>
            <a
              v-if="isOwner(comment.user.id)"
              @click.stop.prevent="handleClickDelete(comment.id)"
            >
              Delete ·
            </a>
            <a>Reply</a> {{ comment.createdAt }}
          </small>
        </p>
      </div>
    </div>
  </article>
</template>

<script>
export default {
  name: "InlineGqlArticleComment",

  props: {
    comment: {
      type: Object
    },

    currentUser: {
      type: Object
    }
  },

  computed: {
    avatarUrl() {
      return this.comment.user.avatarUrl != ""
        ? this.comment.user.avatarUrl
        : "http://bulma.io/images/placeholders/128x128.png";
    },

    isLoggedIn() {
      return !!this.currentUser;
    }
  },

  methods: {
    handleClickDelete(id) {
      this.$emit("delete-comment", id);
    },

    isOwner(id) {
      if (!this.isLoggedIn) {
        return false;
      }
      return id == this.currentUser.id;
    }
  }
};
</script>
