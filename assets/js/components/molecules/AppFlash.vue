<template>
  <div>
    <v-alert
      v-model="alert"
      dismissible
      :type="alertType"
    >
      {{ flashValue }}
    </v-alert>
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
        alert: true
      }
    },

    computed: {
      alertType () {
        if (this.flashKey == 'notice') {
          return 'info';
        } else if (this.flashKey == 'alert') {
          return 'warning';
        } else {
          return this.flashKey;
        }
      },
    }
  }
</script>
