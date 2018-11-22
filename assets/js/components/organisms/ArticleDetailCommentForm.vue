<template>
  <v-layout class="comment-form">
    <v-flex xs12 sm6 offset-sm3>
      <v-card>
        <div id="user" v-if="currentUser">
          <div>こんにちは{{currentUser.name}}さん</div>
        </div>

        <v-form
          v-model="valid"
          ref="form"
          accept-charset="UTF-8"
          method="POST"
          lazy-validation
        >

          <v-textarea
            v-model="body"
            :rules="bodyRules"
            label="Body"
            name="comment[body]"
            required
          />

          <v-btn
            :disabled="!valid"
            @click="addComment"
          >
            submit
          </v-btn>

          <v-btn
            @click="clear"
          >
            clear
          </v-btn>
        </v-form>
      </v-card>
    </v-flex>
  </v-layout>
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

    async addComment() {
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
  margin-top: 20px;
}
</style>
