import Vue from "vue";
import ApolloClient from "apollo-boost";
import VueApollo from "vue-apollo";
import Buefy from "buefy";
import VeeValidate from "vee-validate";
import VueI18n from "vue-i18n";

// VueRouterを使用しないコンポーネント(検証用)
import LoginComponent from "./components/pages/Login.vue";
import ArticleListComponent from "./components/pages/ArticleList.vue";
import ArticleDetailComponent from "./components/pages/ArticleDetail.vue";
import ArticleEditComponent from "./components/pages/ArticleEdit.vue";
import ArticleNewComponent from "./components/pages/ArticleNew.vue";

import router from "./router";

Vue.use(VueApollo);
Vue.use(Buefy);
Vue.use(VeeValidate, { events: "" });
Vue.use(VueI18n);

const uri =
  process.env.NODE_ENV === "production"
    ? "/graphql"
    : "http://localhost:3000/graphql";

const apolloProvider = new VueApollo({
  defaultClient: new ApolloClient({ uri: uri })
});

const componentsList = {
  "login-component": LoginComponent,
  "article-list-component": ArticleListComponent,
  "article-detail-component": ArticleDetailComponent,
  "article-edit-component": ArticleEditComponent,
  "article-new-component": ArticleNewComponent
};

let vms = [];

const i18n = new VueI18n({
  locale: "ja"
});

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
    router,
    i18n
  });
  vms.push(vm);
});

document.addEventListener("beforeunload", () => {
  vms.forEach(vm => {
    vm.$destroy();
  });
  vms = [];
});
