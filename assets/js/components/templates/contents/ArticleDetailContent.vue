<template>
  <v-content>
    <TheFlashes :flashes="flashes" />
    <v-container fluid fill-height>
      <v-layout
        justify-center
        align-center
      >
        <v-flex text-xs-center>
          <ArticleDetailCard
            :article="article"
            :currentUser="currentUser"
          />
          <ArticleDetailComments
            :comments="article.comments"
            :currentUser="currentUser"
          />
          <ArticleDetailCommentForm
            :currentUser="currentUser"
          />
        </v-flex>
      </v-layout>
    </v-container>
  </v-content>
</template>

<script>
  import ArticleDetailCard from '../../organisms/ArticleDetailCard.vue';
  import ArticleDetailComments from '../../organisms/ArticleDetailComments.vue';
  import ArticleDetailCommentForm from '../../organisms/ArticleDetailCommentForm.vue';
  import TheFlashes from '../../organisms/TheFlashes.vue';

  export default {
    name: 'ArticleDetailContent',

    components: {
      'ArticleDetailCard': ArticleDetailCard,
      'ArticleDetailComments': ArticleDetailComments,
      'ArticleDetailCommentForm': ArticleDetailCommentForm,
      'TheFlashes': TheFlashes,
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
