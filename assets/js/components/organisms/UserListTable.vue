<template>
  <div class="box content">
    <UserListItem v-for="user in users" :key="userKey(user.id)" :user="user" />

    <p v-if="noUsers">ユーザーは存在しません</p>
  </div>
</template>

<script>
import UserListItem from "../molecules/UserListItem.vue";

export default {
  name: "UserListTable",

  components: { UserListItem },

  props: {
    users: {
      type: Array
    }
  },

  computed: {
    noUsers() {
      return !this.users || this.users.length == 0;
    }
  },

  methods: {
    userKey(id) {
      return `user-${id}`;
    }
  }
};
</script>
