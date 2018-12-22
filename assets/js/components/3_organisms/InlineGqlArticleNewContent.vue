<template>
  <div class="container">
    <ArticleNewForm v-if="article"
:article="article" />
  </div>
</template>

<script>
import ArticleNewForm from "../3_organisms/InlineGqlArticleEditForm.vue";

export default {
  name: "InlineGqlArticleNewContent",

  components: { ArticleNewForm },

  props: {
    currentUser: {
      type: Object
    }
  },

  data() {
    return {
      article: gon.article
    };
  },

  computed: {
    hasInlineData() {
      return !!gon.article;
    }
  },

  mounted() {
    if (this.hasInlineData) {
      // 別の記事詳細を表示した時にgon.articleを表示しないようにnullにする。
      gon.article = null;
    } else {
      this.article = {
        title: "",
        body: ""
      };
    }
  }
};
</script>
