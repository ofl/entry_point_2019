<template>
  <HeaderlessTemplate>
    <SignUpContent :current-user="currentUser"/>
  </HeaderlessTemplate>
</template>

<script>
import HeaderlessTemplate from "../templates/HeaderlessTemplate.vue";
import SignUpContent from "../organisms/SignUpContent.vue";

export default {
  name: "SignUp",

  components: { HeaderlessTemplate, SignUpContent },

  data() {
    return {
      toolbarTitle: "Sign Up",
      user: gon.user,
      currentUser: gon.currentUser,
      flashes: gon.flashJson
    };
  }
};
</script>
