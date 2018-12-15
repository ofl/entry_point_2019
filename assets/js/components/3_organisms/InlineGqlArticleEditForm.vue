<template>
  <form
    ref="form"
    v-model="valid"
    accept-charset="UTF-8"
    method="POST"
    lazy-validation
  >
    <BField
      label="Title"
      :type="{ 'is-danger': errors.has('title') }"
      :message="errors.first('title')"
    >
      <BInput
        v-model="article.title"
        v-validate="'required'"
        :counter="100"
        name="title"
        placeholder="Title ..."
      />
    </BField>

    <BField
      label="Body"
      :type="{ 'is-danger': errors.has('body') }"
      :message="errors.first('body')"
    >
      <BInput
        v-model="article.body"
        v-validate="'required'"
        name="body"
        type="textarea"
        placeholder="Body ..."
      />
    </BField>

    <BField>
      <p class="control">
        <button
          class="button field is-primary"
          :disabled="!valid"
          @click.stop.prevent="handleClickSubmitBtn"
        >
          <BIcon icon="pencil" />
          <span>Submit</span>
        </button>

        <button class="button field is-info"
@click="clear">
          <BIcon icon="eraser" />
          <span>Clear</span>
        </button>

        <button class="button field is-info"
@click.stop.prevent="back">
          <BIcon icon="backspace" />
          <span>Back</span>
        </button>
      </p>
    </BField>
  </form>
</template>

<script>
import CREATE_ARTICLE_MUTATION from "../../gqls/createArticle.gql";
import UPDATE_ARTICLE_MUTATION from "../../gqls/updateArticle.gql";

export default {
  name: "InlineGqlArticleEditForm",

  props: {
    article: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      valid: true,

      article: {
        id: null,
        title: "",
        body: ""
      }
    };
  },

  computed: {
    isUpdate() {
      return !!this.article.id;
    }
  },

  methods: {
    clear() {
      this.article.title = "";
      this.article.body = "";
      this.$refs.form.reset();
    },

    back() {
      this.$router.go(-1);
    },

    handleClickSubmitBtn() {
      this.$validator.validateAll().then(result => {
        if (!result) {
          return;
        }

        if (this.isUpdate) {
          this.editArticle();
        } else {
          this.newArticle();
        }
      });
    },

    handleServerValidationErrors(serverErrors) {
      serverErrors.forEach(error => {
        this.errors.add({ field: error.path[1], msg: error.message });
      });
    },

    async newArticle() {
      await this.$apollo
        .mutate({
          mutation: CREATE_ARTICLE_MUTATION,
          variables: {
            attributes: {
              title: this.article.title,
              body: this.article.body
            }
          },
          update: (
            store,
            {
              data: {
                createArticle: { article, errors }
              }
            }
          ) => {
            if (errors.length > 0) {
              this.handleServerValidationErrors(errors);
              return;
            }

            this.$toast.open({
              message: "Successfully created article.",
              type: "is-success"
            });

            this.$router.push({
              name: "InlineGqlArticle",
              params: { id: article.id }
            });
          }
        })
        .then(data => {
          console.log(data);
        })
        .catch(error => {
          // Error
          console.error(error);
        });
    },

    async editArticle() {
      await this.$apollo
        .mutate({
          mutation: UPDATE_ARTICLE_MUTATION,
          variables: {
            id: this.article.id,
            attributes: {
              title: this.article.title,
              body: this.article.body
            }
          },
          update: (
            store,
            {
              data: {
                updateArticle: { article, errors }
              }
            }
          ) => {
            if (errors.length > 0) {
              this.handleServerValidationErrors(errors);
              return;
            }

            this.$toast.open({
              message: "Successfully update article.",
              type: "is-success"
            });

            this.$router.push({
              name: "InlineGqlArticle",
              params: { id: article.id }
            });
          }
        })
        .then(data => {
          console.log(data);
        })
        .catch(error => {
          // Error
          console.error(error);
        });
    }
  }
};
</script>
