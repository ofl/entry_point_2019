<template>
  <div class="media-content">
    <form ref="form" accept-charset="UTF-8" method="POST" lazy-validation>
      <div class="field">
        <p class="control">
          <BField>
            <BInput
              v-model.lazy="keyword"
              v-validate="'required'"
              placeholder="Search..."
              type="search"
              icon="magnify"
              name="keyword"
            ></BInput>
          </BField>
        </p>
      </div>
    </form>
  </div>
</template>

<script>
export default {
  name: "SearchForm",

  data() {
    return {
      valid: true,
      keyword: ""
    };
  },

  watch: {
    keyword: function(value) {
      if (value.length > 0) {
        this.$emit("search", value);
      } else {
        this.$emit("reset");
      }
    }
  }
};
</script>
