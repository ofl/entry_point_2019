<template>
  <section class="section main-contents">
    <TheFlashes :flashes="flashes" />

    <div class="container"><ArticleEditForm :article="article" /></div>
  </section>
</template>

<script>
import ArticleEditForm from "../3_organisms/ArticleEditForm.vue";
import TheFlashes from "../3_organisms/TheFlashes.vue";

export default {
  name: "ArticleEditContent",

  components: {
    ArticleEditForm: ArticleEditForm,
    TheFlashes: TheFlashes
  },

  props: {
    article: {
      type: Object
    },
    flashes: {
      type: Object
    }
  }
};
</script>
