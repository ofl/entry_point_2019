import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'

const componentsList = {
  'main-component': require('./components/pages/Main.vue'),
  'article-list-component': require('./components/pages/ArticleList.vue'),
  'article-detail-component': require('./components/pages/ArticleDetail.vue'),
  'article-edit-component': require('./components/pages/ArticleEdit.vue'),
  'article-new-component': require('./components/pages/ArticleNew.vue'),
}

Vue.use(Vuetify)

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
  });
  vms.push(vm)
})

document.addEventListener('beforeunload', () => {
  vms.forEach(vm => {
    vm.$destroy()
  })
  vms = []
})
