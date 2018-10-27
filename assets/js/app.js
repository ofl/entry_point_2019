import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify)

document.addEventListener("DOMContentLoaded", () => {
  const app = new Vue({
    el: '#app',
    components: {
      'main-component': require('./components/pages/Main.vue'),
      'article-list-component': require('./components/pages/ArticleList.vue'),
    },
    data: () => ({
      articles: rails.articles,
    }),
  });
})
