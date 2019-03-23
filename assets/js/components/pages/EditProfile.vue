<template>
  <GeneralTemplate>
    <EditProfileContent :current-user="currentUser" />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import EditProfileContent from "../organisms/EditProfileContent.vue";

import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "EditProfile",

  components: { GeneralTemplate, EditProfileContent },

  data() {
    return {
      toolbarTitle: "Edit Profile",
      currentUser: gon.currentUser,
      flashes: gon.flashJson
    };
  },

  computed: {
    hasInlineUserData() {
      return !!gon.currentUser;
    }
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY,
      skip() {
        return this.hasInlineUserData;
      }
    }
  },

  mounted() {
    if (this.hasInlineUserData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: CURRENT_USER_QUERY,
        data: { currentUser: gon.currentUser }
      });
    }
  }
};
</script>
