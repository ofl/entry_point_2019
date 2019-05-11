<template>
  <form ref="form" :action="requestPath" accept-charset="UTF-8" method="POST">
    <input type="hidden" name="authenticity_token" :value="csrfToken">
    <input type="hidden" name="_method" value="delete">
  </form>
</template>

<script>
export default {
  name: "DeleteForm",

  props: {
    requestPath: {
      type: String
    }
  },

  computed: {
    csrfToken() {
      return document
        .querySelector('meta[name="csrf-token"]')
        .getAttribute("content");
    }
  }
};
</script>
