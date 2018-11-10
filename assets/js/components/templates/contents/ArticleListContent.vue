<template>
  <v-content>
    <TheFlashes :flashes="flashes" />
    <div>
      <v-container fluid>
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

      <div class="new-button">
        <v-btn
          @click="onClickNewBtn()"
          color="info"
        >New</v-btn>
      </div>
    </div>
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
        location.href = `/vue_articles/${id}`;
      },
      onClickNewBtn () {
        location.href = '/vue_articles/new';
      },
    }
  }
</script>
