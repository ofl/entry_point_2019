<template>
  <v-app id="inspire" v-cloak>
    <my-navigation :currentUser="currentUser"></my-navigation>
    <my-toolbar :title="toolbarTitle"></my-toolbar>
    <my-content :articles="articles" :flashes="flashes"></my-content>
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
  import Content from '../templates/contents/ArticleList.vue';

  export default {
    name: 'article-list',
    components: {
      'my-navigation': Navigation,
      'my-toolbar': Toolbar,
      'my-content': Content,
      'my-footer': Footer
    },
    props: {
      rails: {
        type: Object
      }
    },
    data: () => ({
      toolbarTitle: 'Articles',
      articles: rails.articles,
      currentUser: rails.currentUser,
      flashes: rails.flashJson,
    })
  };
</script>
