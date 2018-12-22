<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <MainContent />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../4_templates/GeneralTemplate.vue";
import MainContent from "../3_organisms/MainContent.vue";

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
