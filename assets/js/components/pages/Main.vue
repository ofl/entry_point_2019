<i18n src="../../i18n/main.json" />

<template>
  <GeneralTemplate :current-user="currentUser"
:flashes="flashes">
    <MainContent :current-user="currentUser" />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import MainContent from "../organisms/MainContent.vue";

import SetTitleMixin from "../../utils/setTitle";

export default {
  name: "Main",

  components: { GeneralTemplate, MainContent },

  mixins: [SetTitleMixin],

  data() {
    return {
      currentUser: this.$rails.currentUser,
      flashes: this.$rails.flashJson
    };
  }
};
</script>
