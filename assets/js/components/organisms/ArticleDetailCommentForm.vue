<template>
  <v-layout class="comment-form">
    <v-flex xs12 sm6 offset-sm3>
      <v-card>
        <v-form
          v-model="valid"
          ref="form"
          accept-charset="UTF-8"
          method="POST"
          lazy-validation
        >

          <v-textarea
            v-model="comment.attributes.body"
            :rules="bodyRules"
            label="Body"
            name="comment[body]"
            required
          />

          <v-btn
            :disabled="!valid"
            @click="onClickNewBtn"
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
  export default {
    name: 'ArticleDetailCommentForm',

    props: {
      currentUser: {
        type: Object
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

        comment: {
          articleId: "",
          attributes: {
            body: ""
          }
        }
      }
    },

    methods: {
      onClickNewBtn () {
      },
      clear () {
        this.$refs.form.reset()
      },
    }
  }
</script>

<style scoped>
.comment-form {
  margin-top: 20px;
}
</style>
