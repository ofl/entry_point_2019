<template>
  <v-layout>
    <v-flex xs12 sm6 offset-sm3>
      <v-card>
        <v-img
          src="https://cdn.vuetifyjs.com/images/cards/desert.jpg"
          aspect-ratio="2.75"
        ></v-img>

        <v-card-title primary-title>
          <div>
            <h3 class="headline mb-0">{{ article.title }}</h3>
            <div>{{ article.body }}</div>
          </div>
        </v-card-title>

        <v-card-actions>
          <v-btn
            v-if=isOwner()
            flat color="orange"
            @click="onClickEditBtn()"
          >Edit</v-btn>
          <v-btn flat color="orange">Share</v-btn>
        </v-card-actions>
      </v-card>
    </v-flex>
  </v-layout>
</template>

<script>
  export default {
    props: {
      article: {
        type: Object
      },
      currentUser: {
        type: Object
      }
    },
    methods: {
      onClickEditBtn() {
        location.pathname = `/vue_articles/${this.article.id}/edit`;
      },
      isOwner() {
        return this.article.user_id == this.currentUser.id;
      }
    }
  }
</script>
