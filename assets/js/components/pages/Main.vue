<template>
  <v-app id="inspire" v-cloak>
    <my-navigation></my-navigation>
    <my-toolbar></my-toolbar>
    <my-content></my-content>
    <my-footer></my-footer>
  </v-app>
</template>

<style>
  [v-cloak] {
    /* display: none; */
  }
</style>

<script>
    import Navigation from '../templates/Navigation.vue';
    import Toolbar from '../templates/Toolbar.vue';
    import Footer from '../templates/Footer.vue';
    import Content from '../templates/contents/Main.vue';

    export default {
        components: {
            'my-navigation': Navigation,
            'my-toolbar': Toolbar,
            'my-content': Content,
            'my-footer': Footer
        }
        // ページ全体に及ぶロジックを記述
    };
</script>
