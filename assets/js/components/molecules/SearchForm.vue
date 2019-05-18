<template>
  <div class="media-content">
    <form ref="form" accept-charset="UTF-8" method="POST" lazy-validation>
      <div class="field">
        <p class="control">
          <BField>
            <BInput
              v-model="keyword"
              v-validate="'required'"
              placeholder="Search..."
              type="search"
              icon="magnify"
              name="keyword"
            ></BInput>

            <button
              class="button field is-light search-button"
              :disabled="!valid"
              @click.stop.prevent="handleSubmit"
            >
              <BIcon icon="magnify"/>
              <span>Search</span>
            </button>
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

  methods: {
    handleSubmit() {
      this.$validator.validateAll().then(result => {
        if (result) {
          this.$emit("search", this.keyword);
          return;
        }
      });
    }
  }
};
</script>

<style scoped>
.search-button {
  margin: 0 0 0 1rem;
}
</style>
