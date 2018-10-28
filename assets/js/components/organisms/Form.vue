<template>
  <v-form
    :action="action"
    ref="form"
    v-model="valid"
    accept-charset="UTF-8"
    method="POST"
    lazy-validation
  >
    <input name="utf8" type="hidden" value="✓">
    <input type="hidden" name="authenticity_token" :value="csrfToken">
    <input name="_method" type="hidden" value="put" />
    <v-text-field
      v-model="article.title"
      :rules="titleRules"
      :counter="100"
      label="Title"
      name="article[title]"
      required
    ></v-text-field>

    <v-textarea
      v-model="article.body"
      :rules="bodyRules"
      label="Body"
      name="article[body]"
      required
    ></v-textarea>

    <v-btn
      :disabled="!valid"
      @click="submit"
    >
      submit
    </v-btn>
    <v-btn @click="clear">clear</v-btn>
  </v-form>
</template>

<script>
  export default {
    props: {
      article: {
        type: Object
      }
    },
    data: () => ({
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
    }),
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
    computed: {
      csrfToken () {
        return document.querySelector('meta[name="csrf-token"]').getAttribute('content');
      },
      action () {
        return `/vue_articles/${this.article.id}`;
      }
    }
  }
</script>
