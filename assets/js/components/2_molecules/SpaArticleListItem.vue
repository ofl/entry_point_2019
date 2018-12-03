<template>
  <article
    class="post"
  >
    <a
      href="#"
      @click="onClickItem(article.id)"
    >
      <h4>{{ article.title }}</h4>
    </a>

    <div class="media">
      <div class="media-left">
        <p class="image is-32x32">
          <img
            :src="avatarUrl"
          >
        </p>
      </div>

      <div class="media-content">
        <div class="content">
          <p>
            <a href="#">{{ article.user.name }}</a>{{ article.createdAt }} &nbsp;
            <span class="tag">Question</span>
          </p>
        </div>
      </div>

      <div class="media-right">
        <span class="has-text-grey-light"><i class="fa fa-comments"></i> {{ article.commentsCount }}</span>
        <span class="has-text-grey-light"><i class="fa fa-heart"></i> {{ article.likesCount }}</span>
      </div>
    </div>
  </article>
</template>

<script>
export default {
  name: 'SpaArticleListItem',

  props: {
    article: {
      type: Object
    }
  },

  methods: {
    onClickItem (id) {
      location.href = `/vue_articles/${id}`;
    },
  },

  computed: {
    avatarUrl () {
      return (this.article.user.avatar != '') ? this.article.user.avatar : "http://bulma.io/images/placeholders/128x128.png";
    },
  },
}
</script>

<style scoped>
.media-left img {
  border-radius: 50%;
}
.media-content p {
  font-size: 14px;
  line-height: 2.3;
  font-weight: 700;
  color: #8F99A3;
}
article.post {
  margin: 1rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #E6EAEE;
}
article.post:last-child {
  padding-bottom: 0;
  border-bottom: none;
}
.menu-list li{
  padding: 5px;
}
</style>
