<template>
  <GeneralTemplate :current-user="currentUser" :flashes="flashes">
    <FavoriteListContent :articles="favorites" :current-user="currentUser"/>
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import FavoriteListContent from "../organisms/FavoriteListContent.vue";

import FAVORITE_INDEX_QUERY from "../../gqls/favorites.gql";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";
import SEARCH_ARTICLES_QUERY from "../../gqls/searchArticles.gql";

import SetTitleMixin from "../../utils/setTitle";

export default {
  name: "FavoriteList",

  components: { GeneralTemplate, FavoriteListContent },

  mixins: [SetTitleMixin],

  data() {
    return {
      toolbarTitle: "Favorite Articles",
      currentUser: gon.currentUser,
      favorites: gon.favorites,
      flashes: gon.flashJson
    };
  },

  computed: {
    hasInlineUserData() {
      return !!gon.currentUser;
    },
    hasInlineFavoritesData() {
      return !!gon.favorites;
    }
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY,
      skip() {
        return this.hasInlineUserData;
      }
    },
    favorites: {
      query: FAVORITE_INDEX_QUERY,
      skip() {
        return this.hasInlineFavoritesData;
      }
    }
  },

  mounted() {
    // Gonからデータを取得した場合、Apollo client キャッシュへの書き込む

    if (this.hasInlineUserData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: CURRENT_USER_QUERY,
        data: { currentUser: gon.currentUser }
      });
    }

    if (this.hasInlineFavoritesData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: FAVORITE_INDEX_QUERY,
        data: { favorites: gon.favorites }
      });
    }
  }
};
</script>
