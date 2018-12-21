<template>
  <div>
    <TheNavigation :current-user="currentUser" />
    <AppContent :current-user="currentUser"
:flashes="flashes" />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from "../3_organisms/TheNavigation.vue";
import TheFooter from "../3_organisms/TheFooter.vue";
import AppContent from "../4_templates/Main.vue";

export default {
  name: "Main",

  components: {
    TheNavigation: TheNavigation,
    AppContent: AppContent,
    TheFooter: TheFooter
  },

  data() {
    return {
      currentUser: gon.currentUser,
      flashes: gon.flashJson
    };
  }
};
</script>
