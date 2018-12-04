import Vue from 'vue';
import VueRouter from 'vue-router';

Vue.use(VueRouter);

const routes = [
  { path: '/', component: require('./components/5_pages/Main.vue') },
  { path: '/spa_articles', component: require('./components/5_pages/SpaArticleList.vue') },
  { path: '/spa_articles/:id', component: require('./components/5_pages/SpaArticleDetail.vue'), name: 'SpaArticle' },
];

export default new VueRouter({
  routes,
  mode: 'history'
});
