<template>
  <form
    ref="form"
    v-model="valid"
    accept-charset="UTF-8"
    method="POST"
    lazy-validation
  >
    <BField
      label="Name"
      :type="{ 'is-danger': errors.has('name') }"
      :message="errors.first('name')"
    >
      <BInput
        v-model="profile.name"
        v-validate="'required'"
        :counter="100"
        name="name"
        placeholder="Name ..."
      />
    </BField>

    <BField
      label="Email"
      :type="{ 'is-danger': errors.has('email') }"
      :message="errors.first('email')"
    >
      <BInput
        v-model="profile.email"
        v-validate="'required'"
        name="email"
        placeholder="Email ..."
      />
    </BField>

    <BField
      label="Avatar"
      :type="{ 'is-danger': errors.has('avatar') }"
      :message="errors.first('avatar')"
    >
      <input
        type="file"
        @change="handleFileChange"
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
import UPDATE_PROFILE_MUTATION from "../../gqls/updateProfile.gql";

export default {
  name: "EditProfileForm",

  props: {
    profile: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      valid: true
    };
  },

  methods: {
    clear() {
      this.profile.name = "";
      this.profile.email = "";
      this.profile.avatar = "";
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

        this.updateProfile();
      });
    },

    handleServerValidationErrors(serverErrors) {
      serverErrors.forEach(error => {
        this.errors.add({ field: error.path[1], msg: error.message });
      });
    },

    handleFileChange(e) {
      this.profile.avatar = e.target.files[0];
    },

    async updateProfile() {
      await this.$apollo
        .mutate({
          mutation: UPDATE_PROFILE_MUTATION,
          variables: {
            id: this.profile.id,
            attributes: {
              name: this.profile.name,
              email: this.profile.email,
              avatar: this.profile.avatar
            }
          },
          update: (
            store,
            {
              data: {
                updateProfile: { profile, errors }
              }
            }
          ) => {
            if (errors.length > 0) {
              this.handleServerValidationErrors(errors);
              return;
            }

            this.$toast.open({
              message: "Successfully update profile.",
              type: "is-success"
            });

            this.$router.push({
              name: "EditProfile",
              params: { id: profile.id }
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
