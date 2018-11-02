<template>
  <v-content>
    <flashes :flashes="flashes"></flashes>
    <v-container fluid fill-height>
      <v-layout
        justify-center
        align-center
      >
        <v-flex text-xs-center>
          <article-list :articles="articles" @click-item="onClickItem"></article-list>
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
  import List from '../../organisms/List.vue';
  import Flashes from '../../organisms/Flashes.vue';

  export default {
    name: 'article-list-contents',
    components: {
      'article-list': List,
      'flashes': Flashes,
    },
    props: {
      articles: {
        type: Array
      },
      flashes: {
        type: Object
      }
    },
    methods: {
      onClickItem(id) {
        location.href = `vue_articles/${id}`;
      }
    }
  }
</script>
