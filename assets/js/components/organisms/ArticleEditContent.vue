<template>
  <div class="container">
    <ArticleEditForm :article="article"/>
  </div>
</template>

<script>
import ArticleEditForm from "../organisms/ArticleEditForm.vue";

export default {
  name: "ArticleEditContent",

  components: { ArticleEditForm },

  props: {
    article: {
      type: Object
    }
  }
};
</script>
