import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'

const componentsList = {
  'main-component': require('./components/pages/Main.vue'),
  'article-list-component': require('./components/pages/ArticleList.vue'),
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
    data: () => ({
      rails: rails,
    }),
  });
  vms.push(vm)
})

document.addEventListener('beforeunload', () => {
  vms.forEach(vm => {
    vm.$destroy()
  })
  vms = []
})
