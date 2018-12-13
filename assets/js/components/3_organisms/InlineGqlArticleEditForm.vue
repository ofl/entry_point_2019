<template>
  <form
    v-model="valid"
    ref="form"
    accept-charset="UTF-8"
    method="POST"
    lazy-validation
  >
    <b-field
      label="Title"
      :type="{'is-danger': errors.has('title')}"
      :message="errors.first('title')"
    >
      <b-input
        v-model="article.title"
        :counter="100"
        name="title"
        placeholder="Title ..."
        v-validate="'required'"
      />
    </b-field>

    <b-field
      label="Body"
      :type="{'is-danger': errors.has('body')}"
      :message="errors.first('body')"
    >
      <b-input
        v-model="article.body"
        name="body"
        type="textarea"
        placeholder="Body ..."
        v-validate="'required'"
      />
    </b-field>

    <b-field>
      <p class="control">
        <button
          class="button field is-primary"
          :disabled="!valid"
          @click.stop.prevent="onClickSubmitBtn"
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
import CREATE_ARTICLE_MUTATION from '../../gqls/createArticle.gql';
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

    onClickSubmitBtn () {
      if (this.isUpdate) {
        this.editArticle();
      } else {
        this.newArticle();
      }
    },

    handleServerValidationErrors (serverErrors) {
      serverErrors.forEach(error => {
        this.errors.add({ field: error.path[1], msg: error.message });
      })
    },

    async newArticle() {
      await this.$apollo.mutate({
        mutation: CREATE_ARTICLE_MUTATION,
        variables: {
          attributes: {
            title: this.article.title,
            body: this.article.body,
          },
        },
        update: (store, { data: { createArticle: { article, errors } } }) => {
          this.errors.clear();
          if (errors.length > 0) {
            this.handleServerValidationErrors(errors);
            return;
          }

          this.$toast.open({
            message: 'Successfully created aericle.',
            type: 'is-success'
          })

          this.$router.push({ name: 'InlineGqlArticle', params: { id: article.id }})
        }
      }).then((data) => {
        console.log(data)
      }).catch((error) => {
        // Error
        console.error(error)
      })
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
    },
  },
}
</script>
