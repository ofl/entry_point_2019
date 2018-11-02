<template>
  <v-content>
    <flashes :flashes="flashes"></flashes>
    <v-container fluid fill-height>
      <v-layout
        justify-center
        align-center
      >
        <v-flex text-xs-center>
          <article-detail :article="article" :currentUser="currentUser"></article-detail>
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
  import Detail from '../../organisms/Detail.vue';
  import Flashes from '../../organisms/Flashes.vue';

  export default {
    name: 'article-detail-contents',
    components: {
      'article-detail': Detail,
      'flashes': Flashes,
    },
    props: {
      article: {
        type: Object
      },
      currentUser: {
        type: Object
      },
      flashes: {
        type: Object
      }
    }
  }
</script>
