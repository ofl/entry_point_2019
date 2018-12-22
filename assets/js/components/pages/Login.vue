<template>
  <HeaderlessTemplate :flashes="flashes">
    <LoginContent :user="user" />
  </HeaderlessTemplate>
</template>

<script>
import HeaderlessTemplate from "../templates/HeaderlessTemplate.vue";
import LoginContent from "../organisms/LoginContent.vue";

export default {
  name: "Login",

  components: {
    HeaderlessTemplate,
    LoginContent
  },

  data() {
    return {
      user: gon.user,
      flashes: gon.flashJson
    };
  }
};
</script>
