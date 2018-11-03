<template>
  <v-content>
    <TheFlashes :flashes="flashes" />
    <v-container fluid fill-height>
      <v-layout
        justify-center
        align-center
      >
        <v-flex text-xs-center>
          <ArticleEditForm :article="article"></ArticleEditForm>
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
  import ArticleEditForm from '../../organisms/ArticleEditForm.vue';
  import TheFlashes from '../../organisms/TheFlashes.vue';

  export default {
    name: 'ArticleEditContent',

    components: {
      'ArticleEditForm': ArticleEditForm,
      'TheFlashes': TheFlashes,
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
