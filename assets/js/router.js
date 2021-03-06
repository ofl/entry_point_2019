import Vue from "vue";
import VueRouter from "vue-router";

import Main from "./components/pages/Main.vue";
import InlineGqlArticleList from "./components/pages/InlineGqlArticleList.vue";
import InlineGqlArticleNew from "./components/pages/InlineGqlArticleNew.vue";
import InlineGqlArticleEdit from "./components/pages/InlineGqlArticleEdit.vue";
import InlineGqlArticleDetail from "./components/pages/InlineGqlArticleDetail.vue";
import FavoriteList from "./components/pages/FavoriteList.vue";
import GqlArticleList from "./components/pages/GqlArticleList.vue";
import GqlArticleDetail from "./components/pages/GqlArticleDetail.vue";
import SignUp from "./components/pages/SignUp.vue";
import EditProfile from "./components/pages/EditProfile.vue";
import User from "./components/pages/User.vue";
import FollowerList from "./components/pages/FollowerList.vue";
import FollowingList from "./components/pages/FollowingList.vue";

Vue.use(VueRouter);

const routes = [
  { path: "/", component: Main },
  {
    path: "/inline_gql_articles",
    component: InlineGqlArticleList
  },
  {
    path: "/inline_gql_articles/new",
    component: InlineGqlArticleNew,
    name: "InlineGqlArticleNew"
  },
  {
    path: "/inline_gql_articles/:id/edit",
    component: InlineGqlArticleEdit,
    name: "InlineGqlArticleEdit"
  },
  {
    path: "/inline_gql_articles/:id",
    component: InlineGqlArticleDetail,
    name: "InlineGqlArticle"
  },
  {
    path: "/gql_articles",
    component: GqlArticleList
  },
  {
    path: "/gql_articles/:id",
    component: GqlArticleDetail,
    name: "GqlArticle"
  },
  {
    path: "/favorites",
    component: FavoriteList
  },
  {
    path: "/sign_up",
    component: SignUp,
    name: "SignUp"
  },
  {
    path: "/profile/edit",
    component: EditProfile,
    name: "EditProfile"
  },
  {
    path: "/users/:name/followings",
    component: FollowingList,
    name: "Followings"
  },
  {
    path: "/users/:name/followers",
    component: FollowerList,
    name: "Followers"
  },
  {
    path: "/users/:name",
    component: User,
    name: "User"
  }
];

export default new VueRouter({
  routes,
  mode: "history"
});
