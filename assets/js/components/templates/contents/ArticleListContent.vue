<template>
  <v-content>
    <TheFlashes :flashes="flashes" />
    <v-container fluid fill-height>
      <v-layout
        justify-center
        align-center
      >
        <v-flex text-xs-center>
          <ArticleListTable
            :articles="articles"
            @click-item="onClickItem"
          />
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
  import ArticleListTable from '../../organisms/ArticleListTable.vue';
  import TheFlashes from '../../organisms/TheFlashes.vue';

  export default {
    name: 'ArticleListContent',

    components: {
      'ArticleListTable': ArticleListTable,
      'TheFlashes': TheFlashes,
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
      onClickItem (id) {
        location.href = `vue_articles/${id}`;
      }
    }
  }
</script>
