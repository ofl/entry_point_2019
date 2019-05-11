<template>
  <div>
    <TheNavigation :current-user="currentUser"/>

    <section class="section main-contents">
      <TheFlashes :flashes="flashes"/>

      <slot/>
    </section>

    <TheFooter/>
  </div>
</template>

<script>
import TheNavigation from "../organisms/TheNavigation.vue";
import TheFooter from "../organisms/TheFooter.vue";
import TheFlashes from "../organisms/TheFlashes.vue";

export default {
  name: "GeneralTemplate",

  components: {
    TheNavigation,
    TheFooter,
    TheFlashes
  },

  props: {
    currentUser: {
      type: Object
    },
    flashes: {
      type: Object
    }
  }
};
</script>
