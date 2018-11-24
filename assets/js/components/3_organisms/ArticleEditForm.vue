<template>
  <form
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

    <div class="field">
      <p class="control">
        <button
          class="button field is-primary"
          :disabled="!valid"
          @click="submit"
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
