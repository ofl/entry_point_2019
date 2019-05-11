<template>
  <form ref="form" action="/login" accept-charset="UTF-8" method="POST" lazy-validation>
    <p v-if="!errors.has('name')">{{ user.name }}</p>
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

    <BField v-if="!errors.has('email')">{{ user.email }}</BField>
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

    <BField v-if="!errors.has('password')">**********</BField>
    <BField
      v-show="errors.has('password')"
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

    <BField v-if="!errors.has('passwordConfirmation')">**********</BField>
    <BField
      v-show="errors.has('passwordConfirmation')"
      :type="{ 'is-danger': errors.has('passwordConfirmation') }"
      :message="errors.first('passwordConfirmation')"
    >
      <BInput
        ref="passwordConfirmation"
        v-model="user.passwordConfirmation"
        v-validate="'required'"
        size="is-large"
        name="passwordConfirmation"
        type="password"
        placeholder="Your Password"
      />
    </BField>

    <BField>
      <input
        id="exampleCheckbox"
        v-model="isAgreed"
        class="is-checkradio"
        type="checkbox"
        name="exampleCheckbox"
      >
      <label id="agree-label" for="exampleCheckbox">
        I agree to the xxxx
        <a href="/terms" target="_blank">Terms of Service</a> and
        <a href="/privacy_policy" target="_blank">Privacy Policy</a>.
      </label>
    </BField>

    <BField>
      <button
        class="button is-block is-info is-large is-fullwidth"
        :disabled="!isAgreed"
        @click.stop.prevent="handleClickSubmit"
      >Submit</button>
    </BField>

    <BField>
      <button
        class="button is-block is-light is-large is-fullwidth"
        @click.stop.prevent="handleClickBack"
      >Back</button>
    </BField>
  </form>
</template>

<script>
import CREATE_ARTICLE_MUTATION from "../../gqls/createAccount.gql";
import "bulma-extensions/bulma-checkradio/dist/css/bulma-checkradio.min.css";

export default {
  name: "SignUpForm",

  props: {
    user: {
      type: Object
    }
  },

  data() {
    return {
      valid: true,
      isAgreed: false
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

<style scoped>
#agree-label > a {
  color: #0000ff;
  text-decoration: underline;
}
#agree-label > a:link {
  color: #0000ff;
}
#agree-label > a:visited {
  color: #000080;
}
#agree-label > a:hover {
  color: #ff0000;
}
#agree-label > a:active {
  color: #ff8000;
}
</style>
