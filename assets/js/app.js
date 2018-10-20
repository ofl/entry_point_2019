import Vue from 'vue'
import Vuetify from 'vuetify'
import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify)

Vue.component('example-component', require('./components/ExampleComponent.vue'))

const app = new Vue({
    el: '#app'
});
