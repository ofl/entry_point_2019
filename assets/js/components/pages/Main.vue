<i18n src="../../i18n/main.json" />

<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <MainContent />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import MainContent from "../organisms/MainContent.vue";

import SetTitleMixin from "../../utils/setTitle";

export default {
  name: "Main",

  mixins: [SetTitleMixin],

  components: { GeneralTemplate, MainContent },

  data() {
    return {
      currentUser: gon.currentUser,
      flashes: gon.flashJson
    };
  }
};
</script>
