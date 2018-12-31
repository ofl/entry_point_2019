import Vue from "vue";
import ApolloClient from "apollo-boost";
import VueApollo from "vue-apollo";
import Buefy from "buefy";
import VeeValidate from "vee-validate";

import router from "./router";

Vue.use(VueApollo);
Vue.use(Buefy);
Vue.use(VeeValidate, { events: "" });

const uri =
  process.env.NODE_ENV === "production"
    ? "/graphql"
    : "http://localhost:3000/graphql";

const apolloProvider = new VueApollo({
  defaultClient: new ApolloClient({ uri: uri })
});

const componentsList = {
  "main-component": require("./components/pages/Main.vue"),
  "login-component": require("./components/pages/Login.vue"),
  "article-list-component": require("./components/pages/ArticleList.vue"),
  "article-detail-component": require("./components/pages/ArticleDetail.vue"),
  "article-edit-component": require("./components/pages/ArticleEdit.vue"),
  "article-new-component": require("./components/pages/ArticleNew.vue")
};

let vms = [];

document.addEventListener("DOMContentLoaded", () => {
  const el = document.querySelector("#app");
  if (!el) {
    return;
  }

  const componentName = `${el.dataset.vue}-component`;
  if (componentsList[componentName]) {
    Vue.component(componentName, componentsList[componentName]);
  }

  const vm = new Vue({
    el: "#app",
    apolloProvider,
    router
  });
  vms.push(vm);
});

document.addEventListener("beforeunload", () => {
  vms.forEach(vm => {
    vm.$destroy();
  });
  vms = [];
});
