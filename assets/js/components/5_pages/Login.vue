<template>
  <HeaderlessTemplate :flashes="flashes">
    <LoginContent :user="user" />
  </HeaderlessTemplate>
</template>

<script>
import HeaderlessTemplate from "../4_templates/HeaderlessTemplate.vue";
import LoginContent from "../3_organisms/LoginContent.vue";

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
