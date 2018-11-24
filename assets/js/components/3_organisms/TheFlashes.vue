<template>
  <div>
    <AppFlash
      v-for="(value, key) in flashes"
      :key="key"
      :flashKey="key"
      :flashValue="value"
    />
  </div>
</template>

<script>
import AppFlash from '../2_molecules/AppFlash.vue';

export default {
  name: 'TheFlashes',

  components: {
    'AppFlash': AppFlash,
  },

  props: {
    flashes: {
      type: Object
    }
  }
}
</script>
