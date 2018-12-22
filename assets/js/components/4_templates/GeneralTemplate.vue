<template>
  <div>
    <TheNavigation :current-user="currentUser" />

    <section class="section main-contents">
      <TheFlashes :flashes="flashes" />

      <slot />
    </section>

    <TheFooter />
  </div>
</template>

<script>
import TheNavigation from "../3_organisms/TheNavigation.vue";
import TheFooter from "../3_organisms/TheFooter.vue";
import TheFlashes from "../3_organisms/TheFlashes.vue";

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
