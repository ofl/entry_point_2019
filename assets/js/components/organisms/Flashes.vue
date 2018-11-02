<template>
  <div>
    <flash
      v-for="(value, key) in flashes"
      :key="key"
      :flashKey="key"
      :flashValue="value"
    ></flash>
  </div>
</template>

<script>
  import Flash from '../molecules/Flash.vue';

  export default {
    name: 'flashes',
    components: {
      'flash': Flash,
    },
    props: {
      flashes: {
        type: Object
      }
    }
  }
</script>
