<template>
  <form
    v-model="valid"
    action="/user_sessions"
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

    <b-field>
      <b-input
        v-model="user.email"
        :rules="emailRules"
        :counter="100"
        size="is-large"
        name="email"
        type="email"
        placeholder="Email ..."
        maxlength="30"
        required
        autofocused
      />
    </b-field>

    <b-field>
      <b-input
        v-model="user.password"
        :rules="passwordRules"
        size="is-large"
        name="password"
        type="password"
        placeholder="Password ..."
        maxlength="30"
        required
      />
    </b-field>

    <b-field>
      <label class="checkbox">
        <input
          type="checkbox"
          name="remember_me"
        >
        Remember Me
      </label>
    </b-field>

    <button
      class="button is-block is-info is-large is-fullwidth"
    >
      Login
    </button>
  </form>
</template>

<script>
export default {
  name: 'LoginForm',

  props: {
    user: {
      type: Object
    }
  },

  data () {
    return {
      valid: true,

      email: '',
      emailRules: [
        v => !!v || 'Email is required',
        v => (v && v.length <= 100) || 'Email must be less than 100 characters'
      ],

      password: '',
      passwordRules: [
        v => !!v || 'Password is required',
        v => (v && v.length <= 100) || 'Password must be less than 100 characters'
      ],
    }
  },

  computed: {
    csrfToken () {
      return document.querySelector('meta[name="csrf-token"]').getAttribute('content');
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
