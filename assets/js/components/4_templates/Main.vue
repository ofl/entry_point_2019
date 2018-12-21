<template>
  <section class="section main-contents">
    <TheFlashes :flashes="flashes" />

    <div class="container">
      <div class="hero-body">
        <div class="container">
          Hello! I am
          <h1 class="title is-1">Towerofl</h1>
          <h2 class="subtitle is-3">Full Stack Web Developer</h2>
        </div>
      </div>
    </div>
  </section>
</template>

<script>
import TheFlashes from "../3_organisms/TheFlashes.vue";

export default {
  name: "Main",

  components: {
    TheFlashes: TheFlashes
  },

  props: {
    flashes: {
      type: Object
    }
  }
};
</script>

<style scoped="">
.has-same-height .card {
  height: 320px;
  overflow: hidden;
}
</style>
