export default {
  title() {
    return this.$t("title");
  },

  mounted() {
    let { title } = this.$options;
    if (title) {
      title = typeof title === "function" ? title.call(this) : title;
      document.title = `${title} | EP2019`;
    }
  }
};
