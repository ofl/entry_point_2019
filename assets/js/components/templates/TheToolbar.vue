<template>
  <v-toolbar color="indigo" dark fixed app>
    <v-toolbar-side-icon @click.stop="drawer = !drawer" />
    <v-toolbar-title>{{ title }}</v-toolbar-title>
  </v-toolbar>
</template>

<script>
  export default {
    name: 'TheToolbar',

    props: {
      title: {
        type: String,
        default: 'Application',
      }
    },

    data () {
      return {
        drawer: null,
      }
    },
  }
</script>
