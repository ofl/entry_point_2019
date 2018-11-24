<template>
  <article class="media">
    <figure class="media-left">
      <p class="image is-48x48">
        <img src="https://bulma.io/images/placeholders/96x96.png">
      </p>
    </figure>
    <div class="media-content">
      <div class="content">
        <p>
          <strong>{{ comment.user.name }}</strong>
          <br>
          {{ comment.body }}
          <br>
          <small><a>Like</a> · <a>Reply</a>{{ comment.created_at }}</small>
        </p>
      </div>
    </div>
  </article>
</template>

<script>
export default {
  name: 'ArticleComment',

  props: {
    comment: {
      type: Object
    }
  },
}
</script>
