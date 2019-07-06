<template>
  <GeneralTemplate :current-user="currentUser" :flashes="flashes">
    <UserListContent
      v-if="user"
      :user="user"
      :user-name="name"
      :current-user="currentUser"
      :users="followings"
    />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import UserListContent from "../organisms/UserListContent.vue";

import USER_DETAIL_QUERY from "../../gqls/user.gql";
import FOLLWINGS_QUERY from "../../gqls/followings.gql";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "FollowingList",

  components: { GeneralTemplate, UserListContent },

  data() {
    return {
      toolbarTitle: "user",
      currentUser: gon.currentUser,
      user: gon.user,
      followings: gon.followings ? gon.followings : [],
      flashes: {},
      hasInlineUserData: !!gon.user,
      hasInlineFollowingsData: !!gon.followings
    };
  },

  computed: {
    name() {
      return this.$route.params.name;
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
    },
    followings: {
      query: FOLLWINGS_QUERY,
      variables() {
        return {
          name: this.name
        };
      },
      skip() {
        return this.hasInlineFollowingsData;
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
      gon.user = null;
    }
    if (this.hasInlineFollowingsData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: FOLLWINGS_QUERY,
        variables: { name: this.name },
        data: { followings: gon.followings }
      });
      // 別の記事詳細を表示した時にgon.articleを表示しないようにnullにする。
      gon.followings = null;
    }
  }
};
</script>
