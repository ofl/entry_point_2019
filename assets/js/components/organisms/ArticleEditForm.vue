<template>
  <v-form
    v-model="valid"
    :action="requestPath"
    ref="form"
    accept-charset="UTF-8"
    method="POST"
    lazy-validation
  >
    <input
      type="hidden"
      name="utf8"
      value="✓"
    >
    <input
      type="hidden"
      name="authenticity_token"
      :value="csrfToken"
    >
    <input
      type="hidden"
      name="_method"
      :value="requestMethod"
    />
    <v-text-field
      v-model="article.title"
      :rules="titleRules"
      :counter="100"
      label="Title"
      name="article[title]"
      required
    />

    <v-textarea
      v-model="article.body"
      :rules="bodyRules"
      label="Body"
      name="article[body]"
      required
    />

    <v-btn
      :disabled="!valid"
      @click="submit"
    >
      submit
    </v-btn>

    <v-btn
      @click="clear"
    >
      clear
    </v-btn>
  </v-form>
</template>

<script>
  export default {
    name: 'ArticleEditForm',

    props: {
      article: {
        type: Object
      }
    },

    data () {
      return {
        valid: true,

        title: '',
        titleRules: [
          v => !!v || 'Title is required',
          v => (v && v.length <= 100) || 'Title must be less than 100 characters'
        ],

        body: '',
        bodyRules: [
          v => !!v || 'Body is required',
          v => (v && v.length <= 1000) || 'Body must be less than 1000 characters'
        ],
      }
    },

    computed: {
      csrfToken () {
        return document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      },
      requestPath () {
        return this.isUpdate ? `/vue_articles/${this.article.id}` : '/vue_articles';
      },
      requestMethod () {
        return this.isUpdate ? 'put' : 'post';
      },
      isUpdate () {
        return !!this.article.id;
      },
    },

    methods: {
      submit () {
        if (this.$refs.form.validate()) {
          this.$refs.form.$el.submit();
        }
      },
      clear () {
        this.$refs.form.reset()
      },
    },
  }
</script>
