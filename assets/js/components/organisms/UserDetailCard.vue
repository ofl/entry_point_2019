<template>
  <div class="card">
    <div class="card-image">
      <figure class="image is-4by3">
        <img :src="avatarUrl" alt="Placeholder image">
      </figure>
    </div>

    <div class="card-content">
      <div class="content">{{ user.name }}</div>
    </div>
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

  computed: {
    isLoggedIn() {
      return !!this.currentUser;
    },
    avatarUrl() {
      return !!this.user.avatarUrl
        ? this.user.avatarUrl
        : "../images/300x300.png";
    }
  }
};
</script>
