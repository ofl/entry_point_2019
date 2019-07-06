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
          <BIcon pack="fa" icon="user-friends" />
          {{ user.followingCount }} followings
        </span>
      </RouterLink>
      <RouterLink :to="{ name: 'Followers', params: { name: user.name } }" class="card-footer-item">
        <span class="has-text-grey-light">
          <BIcon pack="fa" icon="user-friends" />
          {{ user.followerCount }} followers
        </span>
      </RouterLink>
      <a href="#" class="card-footer-item" @click.stop.prevent="onClickFollowBtn()">
        <span class="has-text-grey-light">
          <BIcon pack="fa" icon="user-plus" :type="followingType" />
          {{ followButtonLabel }}
        </span>
      </a>
    </footer>
  </div>
</template>

<script>
import TOGGLE_FOLLOW_MUTATION from "../../gqls/toggleFollow.gql";

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
    return {};
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
      return this.user.followedByMe ? "is-primary" : null;
    },
    followButtonLabel() {
      return this.user.followedByMe ? "Unfollow" : "Follow";
    }
  },

  methods: {
    async toggleFollow() {
      await this.$apollo
        .mutate({
          mutation: TOGGLE_FOLLOW_MUTATION,
          variables: {
            name: this.user.name
          }
        })
        .then(data => {
          // Result
          const user = data.data.userToggleFollow.user;
          this.updateFollowStatus(user.followerCount);
        })
        .catch(error => {
          // Error
          console.error(error);
        });
    },
    updateFollowStatus(followerCount) {
      this.user.followerCount = followerCount;
    },
    onClickFollowBtn() {
      if (!this.isLoggedIn) {
        this.$dialog.alert("Please login!");
        return;
      }
      this.toggleFollow();
    }
  }
};
</script>
