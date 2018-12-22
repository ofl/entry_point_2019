<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <MainContent />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import MainContent from "../organisms/MainContent.vue";

export default {
  name: "Main",

  components: { GeneralTemplate, MainContent },

  data() {
    return {
      currentUser: gon.currentUser,
      flashes: gon.flashJson
    };
  }
};
</script>
