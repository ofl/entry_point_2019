<template>
  <form
    v-model="valid"
    ref="form"
    accept-charset="UTF-8"
    method="POST"
    lazy-validation
  >
    <b-field label="Title">
      <b-input
        v-model="article.title"
        :rules="titleRules"
        :counter="100"
        name="article[title]"
        placeholder="Title ..."
        required
      />
    </b-field>

    <b-field label="Body">
      <b-input
        v-model="article.body"
        :rules="bodyRules"
        name="article[body]"
        type="textarea"
        placeholder="Body ..."
        required
      />
    </b-field>

    <b-field>
      <p class="control">
        <button
          class="button field is-primary"
          :disabled="!valid"
          @click.stop.prevent="editArticle"
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

        <button
          class="button field is-info"
          @click.stop.prevent="back"
        >
          <b-icon icon="backspace"></b-icon>
          <span>Back</span>
        </button>
      </p>
    </b-field>
  </form>
</template>

<script>
import UPDATE_ARTICLE_MUTATION from '../../gqls/updateArticle.gql';

export default {
  name: 'InlineGqlArticleEditForm',

  props: {
    article: {
      type: Object,
      required: true
    }
  },

  data () {
    return {
      valid: true,

      titleRules: [
        v => !!v || 'Title is required',
        v => (v && v.length <= 100) || 'Title must be less than 100 characters'
      ],

      bodyRules: [
        v => !!v || 'Body is required',
        v => (v && v.length <= 1000) || 'Body must be less than 1000 characters'
      ],
    }
  },

  computed: {
    isUpdate () {
      return !!this.article.id;
    }
  },

  methods: {
    clear () {
      this.$refs.form.reset()
    },

    back () {
      this.$router.go(-1)
    },

    async editArticle() {
      await this.$apollo.mutate({
        mutation: UPDATE_ARTICLE_MUTATION,
        variables: {
          id: this.article.id,
          attributes: {
            title: this.article.title,
            body: this.article.body,
          },
        },
      }).then((data) => {
        console.log(data)
        this.$router.push({ name: 'InlineGqlArticle', params: { id: this.article.id }})
      }).catch((error) => {
        // Error
        console.error(error)
      })
    }
  },
}
</script>
