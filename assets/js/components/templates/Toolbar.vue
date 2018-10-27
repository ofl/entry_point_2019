<template>
  <v-toolbar color="indigo" dark fixed app>
    <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
    <v-toolbar-title>{{ title }}</v-toolbar-title>
  </v-toolbar>
</template>

<script>
  export default {
    data: () => ({
      drawer: null,
    }),
    props: {
      title: {
        default: 'Application',
        type: String
      }
    }
  }
</script>
