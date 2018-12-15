<template>
  <div><AppContent :user="user"
:flashes="flashes" /></div>
</template>

<script>
import AppContent from "../4_templates/contents/LoginContent.vue";

export default {
  name: "Login",

  components: {
    AppContent: AppContent
  },

  data() {
    return {
      user: gon.user,
      flashes: gon.flashJson
    };
  }
};
</script>
