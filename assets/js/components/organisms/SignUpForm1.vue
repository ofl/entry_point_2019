<template>
  <form ref="form" action="/login" accept-charset="UTF-8" method="POST" lazy-validation>
    <BField :type="{ 'is-danger': errors.has('name') }" :message="errors.first('name')">
      <BInput
        v-model="user.name"
        v-validate="'required'"
        :counter="100"
        size="is-large"
        name="name"
        type="name"
        placeholder="Your Name"
        autofocused
      />
    </BField>

    <BField>
      <button
        class="button is-block is-info is-large is-fullwidth"
        @click.stop.prevent="handleClickNext"
      >Next</button>
    </BField>
  </form>
</template>

<script>
export default {
  name: "SignUpForm",

  props: {
    step: {
      type: Number
    },
    user: {
      type: Object
    }
  },

  data() {
    return {
      valid: false
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
    }
  }
};
</script>
