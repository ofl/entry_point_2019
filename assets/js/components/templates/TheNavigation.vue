<template>
  <v-navigation-drawer
    v-model="drawer"
    fixed
    app
  >
    <v-list dense>
      <v-list-tile @click="onClickMenu('/')">
        <v-list-tile-action>
          <v-icon>home</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title>Home</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>

      <v-list-tile @click="onClickMenu('/vue_articles')">
        <v-list-tile-action>
          <v-icon>contact_mail</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title>Articles</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>

      <v-divider
        v-if=isLoggedIn
        dark
        class="my-3"
      ></v-divider>

      <v-list-tile
        v-if=isLoggedIn
        @click="onClickMenu('/vue_articles')"
      >
        <v-list-tile-action>
          <v-icon>contact_mail</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title>{{ currentUser.name }}</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
  export default {
    name: 'TheNavigation',

    props: {
      currentUser: {
        type: Object
      }
    },

    data () {
      return {
        drawer: null,
      }
    },

    computed: {
      isLoggedIn () {
        return !!this.currentUser
      }
    },

    methods: {
      onClickMenu (path) {
        location.href = path;
      },
    }
  }
</script>
