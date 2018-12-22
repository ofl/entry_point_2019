<template>
  <section class="hero is-success is-fullheight">
    <TheFlashes :flashes="flashes" />

    <slot />
  </section>
</template>

<script>
import TheFlashes from "../3_organisms/TheFlashes.vue";

export default {
  name: "HeaderlessTemplate",

  components: { TheFlashes },

  props: {
    flashes: {
      type: Object
    }
  }
};
</script>

<style scoped>
html,
body {
  font-family: "Open Sans", serif;
  font-size: 14px;
  font-weight: 300;
}
.hero.is-success {
  background: #f2f6fa;
}
.hero .nav,
.hero.is-success .nav {
  -webkit-box-shadow: none;
  box-shadow: none;
}
</style>
