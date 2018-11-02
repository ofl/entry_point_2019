<template>
  <v-content>
    <flashes :flashes="flashes"></flashes>
    <v-container fluid fill-height>
      <v-layout
        justify-center
        align-center
      >
        <v-flex text-xs-center>
          <article-edit :article="article"></article-edit>
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
  import Form from '../../organisms/Form.vue';
  import Flashes from '../../organisms/Flashes.vue';

  export default {
    name: 'article-edit-contents',
    components: {
      'article-edit': Form,
      'flashes': Flashes,
    },
    props: {
      article: {
        type: Object
      },
      flashes: {
        type: Object
      }
    }
  }
</script>
