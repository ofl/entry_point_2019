<template>
  <form
    ref="form"
    v-model="valid"
    action="/login"
    accept-charset="UTF-8"
    method="POST"
    lazy-validation
  >
    <BField
      :type="{ 'is-danger': errors.has('email') }"
      :message="errors.first('email')"
    >
      <BInput
        v-model="user.email"
        v-validate="'required|email'"
        :counter="100"
        size="is-large"
        name="email"
        type="email"
        placeholder="Your Email"
        autofocused
      />
    </BField>

    <BField
      :type="{ 'is-danger': errors.has('password') }"
      :message="errors.first('password')"
    >
      <BInput
        ref="password"
        v-model="user.password"
        v-validate="'required'"
        size="is-large"
        name="password"
        type="password"
        placeholder="Your Password"
      />
    </BField>

    <BField
      :type="{ 'is-danger': errors.has('passwordConfirmation') }"
      :message="errors.first('passwordConfirmation')"
    >
      <BInput
        v-model="user.passwordConfirmation"
        v-validate="'required|confirmed:password'"
        size="is-large"
        name="passwordConfirmation"
        type="password"
        placeholder="Password Confirmation"
      />
    </BField>

    <BField>
      <button
        class="button is-block is-info is-large is-fullwidth"
        @click.stop.prevent="handleClickNext"
      >
        Next
      </button>
    </BField>

    <BField>
      <button
        class="button is-block is-light is-large is-fullwidth"
        @click.stop.prevent="handleClickBack"
      >
        Back
      </button>
    </BField>
  </form>
</template>

<script>
export default {
  name: "SignUpForm",

  props: {
    user: {
      type: Object
    }
  },

  data() {
    return {
      valid: true
    };
  },

  methods: {
    handleClickNext() {
      this.$validator.validateAll().then(result => {
        if (!result) {
          return;
        }

        this.$emit("next");
      });
    },
    handleClickBack() {
      this.$emit("back");
    }
  }
};
</script>
