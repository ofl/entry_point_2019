<template>
  <article class="media comment-form">
    <figure class="media-left">
      <p class="image is-64x64">
        <img src="https://bulma.io/images/placeholders/128x128.png">
      </p>
    </figure>

    <div class="media-content">
      <form
        v-model="valid"
        ref="form"
        accept-charset="UTF-8"
        method="POST"
        lazy-validation
      >

        <div class="field">
          <p class="control">
            <b-field
              label="Body"
              :type="{'is-danger': errors.has('body')}"
              :message="errors.first('body')"
            >
              <b-input
                v-model="body"
                label="Body"
                name="body"
                type="textarea"
                placeholder="Add a comment..."
                v-validate="'required'"
              />
            </b-field>
          </p>
        </div>

        <div class="field">
          <p class="control">
            <button
              class="button field is-primary"
              :disabled="!valid"
              @click.stop.prevent="handleSubmit"
            >
              <b-icon icon="pencil"></b-icon>
              <span>Submit</span>
            </button>

            <button
              class="button field is-info"
              @click.stop.prevent="clear"
            >
              <b-icon icon="eraser"></b-icon>
              <span>Clear</span>
            </button>
          </p>
        </div>
      </form>
    </div>
  </article>
</template>

<script>
import ARTICLE_DETAIL_QUERY from '../../gqls/article.gql';
import ADD_COMMENT_MUTATION from '../../gqls/addComment.gql';

export default {
  name: 'ArticleDetailCommentForm',

  props: {
    articleId: {
      type: Number
    }
  },

  data () {
    return {
      valid: true,
      body: '',
      currentUser: null,
    }
  },

  methods: {
    clear () {
      this.body = ''
      this.$refs.form.reset()
    },

    handleSubmit () {
      this.$validator.validateAll().then((result) => {
        if (result) {
          this.addComment();
          return;
        }

        this.$toast.open({
          message: 'Form is not valid! Please check the fields.',
          type: 'is-danger',
          position: 'is-bottom'
        })
      });
    },

    handleServerValidationErrors (serverErrors) {
      serverErrors.forEach(error => {
        this.errors.add({ field: error.path[1], msg: error.message });
      })
    },

    async addComment() {
      await this.$apollo.mutate({
        mutation: ADD_COMMENT_MUTATION,
        variables: {
          articleId: this.articleId,
          attributes: {
            body: this.body,
          },
        },
        update: (store, { data: { createComment } }) => {
          if (createComment.errors.length > 0) {
            this.handleServerValidationErrors(createComment.errors);
            return;
          }

          const data = store.readQuery({ query: ARTICLE_DETAIL_QUERY, variables: {id: this.articleId} });
          data.article.comments.push(createComment.comment);

          store.writeQuery({ query: ARTICLE_DETAIL_QUERY, variables: {id: this.articleId}, data });
          this.clear();
        }
      }).then((data) => {
        console.log(data);
      }).catch((error) => {
        console.error(error)
      })
    }
  },
}
</script>

<style scoped>
.comment-form {
  margin-top: 50px;
}
</style>
