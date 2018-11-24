<template>
  <div id="inspire" v-cloak>
    <TheNavigation :currentUser="currentUser" />
    <AppContent />
    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from '../4_templates/TheNavigation.vue';
import TheFooter from '../4_templates/TheFooter.vue';
import AppContent from '../4_templates/contents/Main.vue';

export default {
  name: 'Main',

  components: {
    'TheNavigation': TheNavigation,
    'AppContent': AppContent,
    'TheFooter': TheFooter
  },

  data () {
    return {
      currentUser: gon.currentUser,
    }
  },
};
</script>
