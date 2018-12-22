import Vue from "vue";
import VueRouter from "vue-router";

Vue.use(VueRouter);

const routes = [
  { path: "/", component: require("./components/pages/Main.vue") },
  {
    path: "/inline_gql_articles",
    component: require("./components/pages/InlineGqlArticleList.vue")
  },
  {
    path: "/inline_gql_articles/new",
    component: require("./components/pages/InlineGqlArticleNew.vue"),
    name: "InlineGqlArticleNew"
  },
  {
    path: "/inline_gql_articles/:id/edit",
    component: require("./components/pages/InlineGqlArticleEdit.vue"),
    name: "InlineGqlArticleEdit"
  },
  {
    path: "/inline_gql_articles/:id",
    component: require("./components/pages/InlineGqlArticleDetail.vue"),
    name: "InlineGqlArticle"
  },
  {
    path: "/gql_articles",
    component: require("./components/pages/GqlArticleList.vue")
  },
  {
    path: "/gql_articles/:id",
    component: require("./components/pages/GqlArticleDetail.vue"),
    name: "GqlArticle"
  }
];

export default new VueRouter({
  routes,
  mode: "history"
});
