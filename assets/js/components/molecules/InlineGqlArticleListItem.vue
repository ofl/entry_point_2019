<template>
  <article class="post">
    <RouterLink :to="{ name: 'InlineGqlArticle', params: { id: article.id } }">
      <h4>{{ article.title }}</h4>
    </RouterLink>

    <div class="media">
      <div class="media-left">
        <p class="image is-32x32">
          <img :src="avatarUrl">
        </p>
      </div>

      <div class="media-content">
        <div class="content">
          <p>
            <RouterLink
              :to="{ name: 'User', params: { name: article.user.name } }"
            >{{ article.user.name }}</RouterLink>
            {{ article.createdAt }} &nbsp;
            <span class="tag">Question</span>
          </p>
        </div>
      </div>

      <div class="media-right">
        <span class="has-text-grey-light">
          <i class="fa fa-comments"/>
          {{ article.commentsCount }}
        </span>
        <span class="has-text-grey-light">
          <i class="fa fa-heart"/>
          {{ article.favoritesCount }}
        </span>
      </div>
    </div>
  </article>
</template>

<script>
export default {
  name: "InlineGqlArticleListItem",

  props: {
    article: {
      type: Object
    }
  },

  computed: {
    avatarUrl() {
      return !!this.article.user.avatarUrl
        ? this.article.user.avatarUrl
        : "../images/300x300.png";
    }
  }
};
</script>

<style scoped>
.media-left img {
  border-radius: 50%;
}
.media-content p {
  font-size: 14px;
  line-height: 2.3;
  font-weight: 700;
  color: #8f99a3;
}
article.post {
  margin: 1rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #e6eaee;
}
article.post:last-child {
  padding-bottom: 0;
  border-bottom: none;
}
.menu-list li {
  padding: 5px;
}
</style>
