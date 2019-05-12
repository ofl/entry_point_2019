<template>
  <div class="container">
    <UserDetailCard :user="user" :currentUser="currentUser"/>
  </div>
</template>

<script>
import UserDetailCard from "../organisms/UserDetailCard.vue";

export default {
  name: "UserDetailContent",

  components: {
    UserDetailCard
  },

  props: {
    user: {
      type: Object,
      required: true
    },
    currentUser: {
      type: Object
    }
  }
};
</script>
