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
          <template v-if="isEditing">
          </template>
          <template v-else>
            {{ comment.body }} <br >
            <small><a>Edit</a> · <a>Delete</a>{{ comment.createdAt }}</small>
          </template>
        </p>
      </div>
    </div>
  </article>
</template>

<script>
export default {
  name: "ArticleComment",

  props: {
    comment: {
      type: Object
    }
  },

  data() {
    return {
      isEditing: false
    };
  },

  computed: {
    avatarUrl() {
      return this.comment.user.avatarUrl != ""
        ? this.comment.user.avatarUrl
        : "http://bulma.io/images/placeholders/128x128.png";
    }
  }
};
</script>
