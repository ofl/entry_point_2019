import Vue from 'vue'
import ApolloClient from 'apollo-boost'
import VueApollo from 'vue-apollo'
import Buefy from 'buefy'

Vue.use(Buefy)

const apolloProvider = new VueApollo({
  defaultClient: new ApolloClient({
    uri: 'http://localhost:3000/graphql'
  })
})
Vue.use(VueApollo)

const componentsList = {
  'main-component': require('./components/5_pages/Main.vue'),
  'login-component': require('./components/5_pages/Login.vue'),
  'article-list-component': require('./components/5_pages/ArticleList.vue'),
  'article-detail-component': require('./components/5_pages/ArticleDetail.vue'),
  'article-edit-component': require('./components/5_pages/ArticleEdit.vue'),
  'article-new-component': require('./components/5_pages/ArticleNew.vue'),
}

let vms = []

document.addEventListener('DOMContentLoaded', () => {
  const el = document.querySelector('#app')
  if (!el) {
    return;
  }

  const componentName = `${el.dataset.vue}-component`
  Vue.component(componentName, componentsList[componentName])

  const vm = new Vue({
    el: '#app',
    apolloProvider,
  });
  vms.push(vm)
})

document.addEventListener('beforeunload', () => {
  vms.forEach(vm => {
    vm.$destroy()
  })
  vms = []
})
