<template>
  <div class="media-content">
    <form
      ref="form"
      v-model="valid"
      accept-charset="UTF-8"
      method="POST"
      lazy-validation
    >
      <div class="field">
        <p class="control">
          <BField
            label="Body"
            :type="{ 'is-danger': errors.has('body') }"
            :message="errors.first('body')"
          >
            <BInput
              v-model="body"
              v-validate="'required'"
              label="Body"
              name="body"
              type="textarea"
              placeholder="Add a comment..."
            />
          </BField>
        </p>
      </div>

      <div class="field">
        <p class="control">
          <button
            class="button field is-primary"
            :disabled="!valid"
            @click.stop.prevent="handleSubmit"
          >
            <BIcon icon="pencil" />
            <span>{{ submitButtonTitle }}</span>
          </button>

          <button class="button field is-info"
@click.stop.prevent="clear">
            <BIcon icon="eraser" />
            <span>Clear</span>
          </button>
        </p>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  name: "CommentForm",

  props: {
    comment: {
      type: Object,
      required: true
    },
    submitButtonTitle: {
      type: String,
      default: "Submit"
    },
    serverErrors: {
      type: Array,
      default: []
    }
  },

  data() {
    return {
      valid: true,
      body: this.comment.body
    };
  },

  methods: {
    clear() {
      this.body = "";
      this.$refs.form.reset();
    },

    handleSubmit() {
      this.$validator.validateAll().then(result => {
        if (result) {
          this.$emit("mutateComment", this.body);
          return;
        }

        this.$toast.open({
          message: "Form is not valid! Please check the fields.",
          type: "is-danger",
          position: "is-bottom"
        });
      });
    }
  },

  watch: {
    serverErrors: function(val) {
      val.forEach(error => {
        this.errors.add({ field: error.path[1], msg: error.message });
      });
    },
    comment: {
      handler: function (val, _) {
        this.body = val.body;
      }
    }
  }
};
</script>
