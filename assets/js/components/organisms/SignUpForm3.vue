<template>
  <form
    ref="form"
    v-model="valid"
    action="/login"
    accept-charset="UTF-8"
    method="POST"
    lazy-validation
  >
    <p v-if="!errors.has('name')">
      {{ user.name }}
    </p>
    <BField
      v-show="errors.has('name')"
      :type="{ 'is-danger': errors.has('name') }"
      :message="errors.first('name')"
    >
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

    <p v-if="!errors.has('email')">
      {{ user.email }}
    </p>
    <BField
      v-show="errors.has('email')"
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

    <p v-if="!errors.has('password')">
      **********
    </p>
    <BField
      v-show="errors.has('password')"
      :type="{ 'is-danger': errors.has('password') }"
      :message="errors.first('password')"
    >
      <BInput
        v-model="user.password"
        v-validate="'required'"
        size="is-large"
        name="password"
        type="password"
        ref="password"
        placeholder="Your Password"
      />
    </BField>

    <p v-if="!errors.has('passwordConfirmation')">
      **********
    </p>
    <BField
      v-show="errors.has('passwordConfirmation')"
      :type="{ 'is-danger': errors.has('passwordConfirmation') }"
      :message="errors.first('passwordConfirmation')"
    >
      <BInput
        v-model="user.passwordConfirmation"
        v-validate="'required'"
        size="is-large"
        name="passwordConfirmation"
        type="password"
        ref="passwordConfirmation"
        placeholder="Your Password"
      />
    </BField>

    <button
      class="button is-block is-info is-large is-fullwidth"
      @click.stop.prevent="handleClickSubmit"
    >
      Submit
    </button>
    <button
      class="button is-block is-light is-large is-fullwidth"
      @click.stop.prevent="handleClickBack"
    >
      Back
    </button>
  </form>
</template>

<script>
import CREATE_ARTICLE_MUTATION from "../../gqls/createAccount.gql";

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
    handleClickSubmit() {
      this.$validator.validateAll().then(result => {
        if (!result) {
          return;
        }

        this.createAccount();
      });
    },

    handleClickBack() {
      this.$emit("back");
    },

    handleServerValidationErrors(serverErrors) {
      serverErrors.forEach(error => {
        this.errors.add({ field: error.path[1], msg: error.message });
      });
    },

    async createAccount() {
      await this.$apollo
        .mutate({
          mutation: CREATE_ARTICLE_MUTATION,
          variables: {
            attributes: {
              name: this.user.name,
              email: this.user.email,
              password: this.user.password,
              passwordConfirmation: this.user.passwordConfirmation
            }
          },
          update: (
            store,
            {
              data: {
                createAccount: { account, errors }
              }
            }
          ) => {
            if (errors.length > 0) {
              this.handleServerValidationErrors(errors);
              return;
            }

            this.$toast.open({
              message: "Successfully created account.",
              type: "is-success"
            });

            this.$emit("next");
            //
            // this.$router.push({
            //   name: "InlineGqlAccount",
            //   params: { id: user.id }
            // });
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
