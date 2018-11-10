<template>
  <v-layout>
    <v-flex xs12 sm6 offset-sm3>
      <v-card>
        <v-list two-line>
           <template v-for="(comment, index) in comments">
             <v-list-tile
               :key="comment.id"
               avatar
               @click=""
             >
               <v-list-tile-avatar>
                 <img :src="comment.user.name">
               </v-list-tile-avatar>

               <v-list-tile-content>
                 <v-list-tile-title v-html="comment.body"></v-list-tile-title>
                 <v-list-tile-sub-title v-html="comment.subtitle">
                   <span class='text--primary'>{{comment.user.name}}</span> &mdash;
                   {{comment.created_at}}
                 </v-list-tile-sub-title>
               </v-list-tile-content>
             </v-list-tile>

             <v-divider
               :inset=true
               :key="index"
             ></v-divider>
           </template>
         </v-list>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
  export default {
    name: 'ArticleDetailComments',

    props: {
      comments: {
        type: Array
      },
      currentUser: {
        type: Object
      }
    },

    computed: {
      isOwner () {
        return this.comments.user_id == this.currentUser.id;
      }
    },

    methods: {
      onClickEditBtn () {
        location.pathname = `/vue_articles/${this.article.id}/edit`;
      },
    }
  }
</script>
