<template>
  <v-content>
    <v-container fluid fill-height>
      <v-layout
        justify-center
        align-center
      >
        <v-flex text-xs-center>
          <article-list :articles="articles"></article-list>
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
  import List from '../../organisms/List.vue';

  export default {
    name: 'article-list-contents',
    components: {
      'article-list': List,
    },
    props: {
      articles: {
        type: Array
      }
    }
  }
</script>
