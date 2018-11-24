<template>
  <div>
    <b-notification
      :type="alertType"
      :active.sync="isActive"
      auto-close
    >
      {{ flashValue }}
    </b-notification>
  </div>
</template>

<script>
export default {
  name: 'AppFlash',

  props: {
    flashKey: {
      type: String
    },
    flashValue: {
      type: String
    }
  },

  data () {
    return {
      isActive: true
    }
  },

  computed: {
    alertType () {
      switch (this.flashKey) {
        case 'notice':
          return 'is-info';
          break;
        case 'alert':
          return 'is-warning';
          break;
        case 'error':
          return 'is-danger';
          break;
        default:
          return `is-${this.flashKey}`;
      }
    },
  }
}
</script>
