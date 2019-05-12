<template>
  <article class="media">
    <figure class="media-left">
      <p class="image is-48x48">
        <img :src="avatarUrl">
      </p>
    </figure>
    <div class="media-content">
      <div class="content">
        <p>
          <strong>{{ comment.user.name }}</strong>
          <br>
          <template v-if="isEditing">
            <CommentForm
              :comment="comment"
              :serverErrors="serverErrors"
              @mutateComment="updateComment"
            />
            <a @click.stop.prevent="handleClickCancel">Cancel</a>
          </template>
          <template v-else>
            {{ comment.body }}
            <br>
            <small>
              <template v-if="isOwner(comment.user.id)">
                <a @click.stop.prevent="handleClickDelete(comment.id)">Delete</a>
                <a @click.stop.prevent="handleClickEdit">Edit</a>
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
import CommentForm from "../molecules/CommentForm.vue";

import ARTICLE_DETAIL_QUERY from "../../gqls/article.gql";
import UPDATE_COMMENT_MUTATION from "../../gqls/updateComment.gql";

export default {
  name: "InlineGqlArticleComment",

  components: { CommentForm },

  props: {
    comment: {
      type: Object
    },

    currentUser: {
      type: Object
    },

    articleId: {
      type: String,
      required: true
    },

    hasInlineArticleData: {
      type: Boolean,
      default: false
    }
  },

  data() {
    return {
      isEditing: false,
      serverErrors: []
    };
  },

  computed: {
    avatarUrl() {
      return !!this.comment.user.avatarUrl
        ? this.comment.user.avatarUrl
        : "../images/300x300.png";
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
    },

    async updateComment(body) {
      await this.$apollo
        .mutate({
          mutation: UPDATE_COMMENT_MUTATION,
          variables: {
            id: this.comment.id,
            attributes: {
              body: body
            }
          },
          update: (store, { data: { updateComment } }) => {
            if (updateComment.errors.length > 0) {
              this.serverErrors = updateComment.errors;
              return;
            }

            const data = store.readQuery({
              query: ARTICLE_DETAIL_QUERY,
              variables: { id: this.articleId }
            });
            data.article.comments.forEach(comment => {
              if (comment.id == updateComment.comment.id) {
                comment.body = updateComment.comment.body;
              }
            });

            store.writeQuery({
              query: ARTICLE_DETAIL_QUERY,
              variables: { id: this.articleId },
              data
            });

            this.isEditing = false;

            if (this.hasInlineArticleData) {
              this.$emit("reloadArticle");
            }
          }
        })
        .then(data => {
          console.log(data);
        })
        .catch(error => {
          console.error(error);
        });
    }
  }
};
</script>
