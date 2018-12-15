<template>
  <form
    ref="form"
    v-model="valid"
    :action="requestPath"
    accept-charset="UTF-8"
    method="POST"
    lazy-validation
  >
    <input
type="hidden" name="utf8" value="✓" />
    <input
type="hidden" name="authenticity_token" :value="csrfToken" />
    <input
type="hidden" name="_method" :value="requestMethod" />

    <BField label="Title">
      <BInput
        v-model="article.title"
        :rules="titleRules"
        :counter="100"
        name="article[title]"
        placeholder="Title ..."
        required
      />
    </BField>

    <BField label="Body">
      <BInput
        v-model="article.body"
        :rules="bodyRules"
        name="article[body]"
        type="textarea"
        placeholder="Body ..."
        required
      />
    </BField>

    <BField>
      <p class="control">
        <button
          class="button field is-primary"
          :disabled="!valid"
          @click="submit"
        >
          <BIcon icon="pencil" />
          <span>Submit</span>
        </button>

        <button class="button field is-info" @click="clear">
          <BIcon icon="eraser" />
          <span>Clear</span>
        </button>
      </p>
    </BField>
  </form>
</template>

<script>
export default {
  name: "ArticleEditForm",

  props: {
    article: {
      type: Object
    }
  },

  data() {
    return {
      valid: true,

      title: "",
      titleRules: [
        v => !!v || "Title is required",
        v => (v && v.length <= 100) || "Title must be less than 100 characters"
      ],

      body: "",
      bodyRules: [
        v => !!v || "Body is required",
        v => (v && v.length <= 1000) || "Body must be less than 1000 characters"
      ]
    };
  },

  computed: {
    csrfToken() {
      return document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content");
    },
    requestPath() {
      return this.isUpdate
        ? `/vue_articles/${this.article.id}`
        : "/vue_articles";
    },
    requestMethod() {
      return this.isUpdate ? "put" : "post";
    },
    isUpdate() {
      return !!this.article.id;
    }
  },

  methods: {
    submit() {
      if (this.$refs.form.validate()) {
        this.$refs.form.$el.submit();
      }
    },
    clear() {
      this.$refs.form.reset();
    }
  }
};
</script>
