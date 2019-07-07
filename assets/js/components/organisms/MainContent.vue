<i18n src="../../i18n/main.json" />

<template>
  <div class="container">
    <div class="hero-body">
      <div class="container">
        {{ $t("hello") }}
        <h1 class="title is-1">{{ name }}</h1>
        <h2 class="subtitle is-3">Full Stack Web Developer</h2>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: "MainContent",

  props: {
    currentUser: {
      type: Object
    }
  },

  computed: {
    name() {
      return this.currentUser ? this.currentUser.name : "Guest";
    }
  }
};
</script>

<style scoped="main">
.has-same-height .card {
  height: 320px;
  overflow: hidden;
}
</style>
