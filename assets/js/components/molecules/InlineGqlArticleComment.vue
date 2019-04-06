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
            <a @click.stop.prevent="handleClickUpdate(comment.id)">
              Update
            </a>
            <a @click.stop.prevent="handleClickCancel">
              Cancel
            </a>
          </template>
          <template v-else>
            {{ comment.body }} <br >
            <small>
              <template v-if="isOwner(comment.user.id)">
                <a @click.stop.prevent="handleClickDelete(comment.id)">
                  Delete
                </a>
                <a @click.stop.prevent="handleClickEdit">
                  Edit
                </a>
              </template>
              {{ comment.createdAt }}
            </small>
          </template>
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
    },

    isLoggedIn() {
      return !!this.currentUser;
    }
  },

  methods: {
    handleClickDelete(id) {
      this.$emit("delete-comment", id);
    },

    handleClickUpdate(id) {
      this.$emit("delete-comment", id);
    },

    handleClickEdit() {
      this.isEditing = true;
    },

    handleClickCancel() {
      this.isEditing = false;
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
