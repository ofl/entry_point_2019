<template>
  <div>
    <AppFlash v-for="(value, key) in flashes" :key="key" :flash-key="key" :flash-value="value"/>
  </div>
</template>

<script>
import AppFlash from "../molecules/AppFlash.vue";

export default {
  name: "TheFlashes",

  components: {
    AppFlash: AppFlash
  },

  props: {
    flashes: {
      type: Object
    }
  }
};
</script>
