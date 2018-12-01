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
            <b-input
              v-model="body"
              :rules="bodyRules"
              label="Body"
              name="comment[body]"
              type="textarea"
              placeholder="Add a comment..."
              required
            />
          </p>
        </div>

        <div class="field">
          <p class="control">
            <button
              class="button field is-primary"
              :disabled="!valid"
              @click="addComment"
            >
              <b-icon icon="pencil"></b-icon>
              <span>Submit</span>
            </button>

            <button
              class="button field is-info"
              @click="clear"
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
import gql from 'graphql-tag';

const HelloQuery = gql`
  query CurrentUser{
    currentUser {
      id
      name
    }
  }
`;
const AddCommentMutation = gql`
  mutation CreateComment($articleId:ID!, $attributes:CommentAttributes!) {
    createComment(input: {articleId:$articleId,attributes: $attributes}) {
      comment {
        id
        body
        user {
          id
          name
          avatar
        }
      }
    }
  }
`;

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
      bodyRules: [
        v => !!v || 'Body is required',
        v => (v && v.length <= 1000) || 'Body must be less than 1000 characters'
      ],

      currentUser: null,
    }
  },

  methods: {
    clear () {
      this.$refs.form.reset()
    },

    async addComment(e) {
      e.preventDefault();

      await this.$apollo.mutate({
        mutation: AddCommentMutation,
        variables: {
          articleId: this.articleId,
          attributes: {
            body: this.body,
          },
        },
      }).then((data) => {
        // Result
        console.log(data)
        this.clear();
      }).catch((error) => {
        // Error
        console.error(error)
      })
    }
  },

  apollo: {
    currentUser: {
      query: HelloQuery,
    }
  },
}
</script>

<style scoped>
.comment-form {
  margin-top: 50px;
}
</style>
