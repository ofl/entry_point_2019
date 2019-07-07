<template>
  <div class="container">
    <UserListTable :users="users" :currentUser="currentUser" />
  </div>
</template>

<script>
import UserListTable from "../organisms/UserListTable.vue";

export default {
  name: "UserListContent",

  components: {
    UserListTable
  },

  props: {
    user: {
      type: Object,
      required: true
    },
    users: {
      type: Array,
      required: true
    },
    currentUser: {
      type: Object
    }
  }
};
</script>
