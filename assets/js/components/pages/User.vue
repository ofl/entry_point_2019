<template>
  <GeneralTemplate :current-user="currentUser" :flashes="flashes">
    <UserDetailContent v-if="user" :user="user" :user-name="name" :current-user="currentUser" />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import UserDetailContent from "../organisms/UserDetailContent.vue";

import USER_DETAIL_QUERY from "../../gqls/user.gql";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "UserDetail",

  components: { GeneralTemplate, UserDetailContent },

  data() {
    return {
      toolbarTitle: "user",
      currentUser: gon.currentUser,
      user: gon.user,
      flashes: {},
      hasInlineUserData: !!gon.article
    };
  },

  computed: {
    name() {
      return this.$route.params.name;
    }
  },

  watch: {
    user: function(val) {
      document.title = `${val.name} | EP2019`;
    }
  },

  apollo: {
    currentUser: {
      query: CURRENT_USER_QUERY
    },
    user: {
      query: USER_DETAIL_QUERY,
      variables() {
        return {
          name: this.name
        };
      },
      skip() {
        return this.hasInlineUserData;
      }
    }
  },

  mounted() {
    if (this.hasInlineUserData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: USER_DETAIL_QUERY,
        variables: { name: this.name },
        data: { user: gon.user }
      });
      // 別の記事詳細を表示した時にgon.articleを表示しないようにnullにする。
      gon.user = null;
    }
  }
};
</script>
