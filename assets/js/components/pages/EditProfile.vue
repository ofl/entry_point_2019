<template>
  <GeneralTemplate >
    <EditProfileContent :current-user="currentUser" />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import EditProfileContent from "../organisms/EditProfileContent.vue";

export default {
  name: "EditProfile",

  components: { GeneralTemplate, EditProfileContent },

  data() {
    return {
      toolbarTitle: "Edit Profile",
      currentUser: gon.currentUser,
      flashes: gon.flashJson
    };
  }
};
</script>
