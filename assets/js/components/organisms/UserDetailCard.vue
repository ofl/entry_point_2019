<template>
  <div class="card">
    <div class="card-image">
      <figure class="image is-4by3">
        <img :src="avatarUrl" alt="Placeholder image" />
      </figure>
    </div>

    <div class="card-content">
      <div class="content">{{ user.name }}</div>
    </div>
    <footer class="card-footer">
      <RouterLink
        :to="{ name: 'Followings', params: { name: user.name } }"
        class="card-footer-item"
      >
        <span class="has-text-grey-light">
          <BIcon pack="fa" icon="user-friends" :type="followingType" />
          {{ user.followingCount }} followings
        </span>
      </RouterLink>
      <RouterLink :to="{ name: 'Followers', params: { name: user.name } }" class="card-footer-item">
        <span class="has-text-grey-light">
          <BIcon pack="fa" icon="user-friends" :type="followingType" />
          {{ user.followerCount }} followers
        </span>
      </RouterLink>
      <a href="#" class="card-footer-item" @click.stop.prevent="onClickFavoriteBtn()">
        <span class="has-text-grey-light">
          <BIcon pack="fa" icon="user-plus" :type="followingType" />
          {{ followButtonLabel }}
        </span>
      </a>
    </footer>
  </div>
</template>

<script>
export default {
  name: "UserDetailCard",

  props: {
    user: {
      type: Object,
      required: true
    },
    currentUser: {
      type: Object
    }
  },

  data() {
    return {
      isFollowing: false,
      isFollowed: false
    };
  },

  computed: {
    isLoggedIn() {
      return !!this.currentUser;
    },
    avatarUrl() {
      return !!this.user.avatarUrl
        ? this.user.avatarUrl
        : "../images/300x300.png";
    },
    isOwner() {
      if (!this.isLoggedIn) {
        return false;
      }
      return this.user.id == this.currentUser.id;
    },
    followingType() {
      return this.isFollowing ? "is-primary" : null;
    },
    followerType() {
      return this.isFollowed ? "is-primary" : null;
    },
    followButtonLabel() {
      return this.isFollowing ? "Unfollow" : "Follow";
    }
  }
};
</script>
