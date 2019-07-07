<template>
  <GeneralTemplate :current-user="currentUser" :flashes="flashes">
    <UserListContent
      v-if="user"
      :user="user"
      :user-name="name"
      :current-user="currentUser"
      :users="followers"
    />
  </GeneralTemplate>
</template>

<script>
import GeneralTemplate from "../templates/GeneralTemplate.vue";
import UserListContent from "../organisms/UserListContent.vue";

import USER_DETAIL_QUERY from "../../gqls/user.gql";
import FOLLWERS_QUERY from "../../gqls/followers.gql";
import CURRENT_USER_QUERY from "../../gqls/currentUser.gql";

export default {
  name: "FollowerList",

  components: { GeneralTemplate, UserListContent },

  data() {
    return {
      toolbarTitle: "user",
      currentUser: gon.currentUser,
      user: gon.user,
      followers: gon.followers ? gon.followers : [],
      flashes: {},
      hasInlineUserData: !!gon.user,
      hasInlineFollowersData: !!gon.followers
    };
  },

  computed: {
    name() {
      return this.$route.params.name;
    }
  },

  watch: {
    user: function(val) {
      document.title = `${val.name}'s follwers list | EP2019`;
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
    followers: {
      query: FOLLWERS_QUERY,
      variables() {
        return {
          name: this.name
        };
      },
      skip() {
        return this.hasInlineFollowersData;
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
    if (this.hasInlineFollowersData) {
      this.$apollo.provider.defaultClient.writeQuery({
        query: FOLLWERS_QUERY,
        variables: { name: this.name },
        data: { followers: gon.followers }
      });
      gon.followers = null;
    }
  }
};
</script>
