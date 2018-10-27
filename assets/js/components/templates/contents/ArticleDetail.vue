<template>
  <v-content>
    <v-container fluid fill-height>
      <v-layout
        justify-center
        align-center
      >
        <v-flex text-xs-center>
          <article-detail :article="article"></article-detail>
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
  import Detail from '../../organisms/Detail.vue';

  export default {
    name: 'article-detail-contents',
    components: {
      'article-detail': Detail,
    },
    props: {
      article: {
        type: Object
      }
    }
  }
</script>
