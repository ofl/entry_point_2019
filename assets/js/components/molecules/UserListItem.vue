<template>
  <div class="post">
    <RouterLink :to="{ name: 'User', params: { name: user.name } }">
      <h4>{{ user.name }}</h4>
    </RouterLink>

    <div class="media">
      <div class="media-left">
        <p class="image is-32x32">
          <img :src="avatarUrl" />
        </p>
      </div>

      <div class="media-right">
        <span class="has-text-grey-light">
          <i class="fa fa-comments" />
          {{ user.followingCount }}
        </span>
        <span class="has-text-grey-light">
          <i class="fa fa-heart" />
          {{ user.followerCount }}
        </span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "UserListItem",

  props: {
    user: {
      type: Object
    }
  },

  computed: {
    avatarUrl() {
      return this.user.avatarUrl != ""
        ? this.user.avatarUrl
        : "../../images/300x300.png";
    }
  },

  methods: {
    onClickItem(name) {
      location.href = `/users/${name}`;
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
user.post {
  margin: 1rem;
  padding-bottom: 1rem;
  border-bottom: 1px solid #e6eaee;
}
user.post:last-child {
  padding-bottom: 0;
  border-bottom: none;
}
.menu-list li {
  padding: 5px;
}
</style>
