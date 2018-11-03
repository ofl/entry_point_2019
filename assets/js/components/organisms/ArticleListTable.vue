<template>
  <v-list two-line subheader>
    <v-list-tile
      v-for="article in articles"
      :key="article.id"
      avatar
      @click="click(article.id)"
    >
      <v-list-tile-avatar>
        <v-icon :class="[article.iconClass]">{{ article.icon }}</v-icon>
      </v-list-tile-avatar>

      <v-list-tile-content>
        <v-list-tile-title>{{ article.title }}</v-list-tile-title>
        <v-list-tile-sub-title>{{ article.user.name }} [{{ article.created_at }}]</v-list-tile-sub-title>
      </v-list-tile-content>

      <v-list-tile-action>
        <v-btn icon ripple>
          <v-icon color="grey lighten-1">info</v-icon>
        </v-btn>
      </v-list-tile-action>
    </v-list-tile>
  </v-list>
</template>

<script>
  export default {
    name: 'ArticleListTable',

    props: {
      articles: {
        type: Array
      }
    },

    methods: {
      click (id) {
        this.$emit('click-item', id);
      }
    }
  }
</script>
