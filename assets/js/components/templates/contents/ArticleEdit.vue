<template>
  <v-content>
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

  export default {
    name: 'article-edit-contents',
    components: {
      'article-edit': Form,
    },
    props: {
      article: {
        type: Object
      }
    }
  }
</script>
