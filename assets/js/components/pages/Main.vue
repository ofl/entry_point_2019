<template>
  <v-app id="inspire" v-cloak>
    <TheNavigation />
    <TheToolbar />
    <AppContent />
    <TheFooter />
  </v-app>
</template>

<script>
  import TheNavigation from '../templates/TheNavigation.vue';
  import TheToolbar from '../templates/TheToolbar.vue';
  import TheFooter from '../templates/TheFooter.vue';
  import AppContent from '../templates/contents/Main.vue';

  export default {
    name: 'Main',

    components: {
      'TheNavigation': TheNavigation,
      'TheToolbar': TheToolbar,
      'AppContent': AppContent,
      'TheFooter': TheFooter
    }
  };
</script>

<style>
  [v-cloak] {
    /* display: none; */
  }
</style>
