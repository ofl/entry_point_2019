<template>
  <nav class="navbar is-link is-fixed-top" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <a class="navbar-item" href="/">
        <img src="https://bulma.io/images/bulma-logo.png" width="112" height="28">
      </a>
      <a role="button" class="navbar-burger burger" aria-label="menu" aria-expanded="false" data-target="navbarExampleTransparentExample">
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
      </a>
    </div>

    <div id="navbarExampleTransparentExample" class="navbar-menu">
      <div class="navbar-end">
        <a
          class="navbar-item"
          href="#"
          @click.stop.prevent="onClickMenu('/')"
        >
          <span class="icon">
            <i class="fas fa-info"></i>
          </span>
          <span>Home</span>
        </a>
        <a
          class="navbar-item"
          href="#"
          @click.stop.prevent="onClickMenu('/vue_articles')"
        >
          <span class="icon">
            <i class="fas fa-bars"></i>
          </span>
          <span>Vue Articles</span>
        </a>
        <a
          class="navbar-item"
          href="#"
          @click.stop.prevent="onClickMenu('/articles')"
        >
          <span class="icon">
            <i class="fas fa-file-alt"></i>
          </span>
          <span>Articles</span>
        </a>
        <a
          v-if=!isLoggedIn
          class="navbar-item"
          href="#"
          @click.stop.prevent="onClickMenu('/login')"
        >
          <span class="icon">
            <i class="fas fa-th-list"></i>
          </span>
          <span>Login</span>
        </a>
        <a
          v-if=isLoggedIn
          class="navbar-item"
          href="#"
          @click.stop.prevent="onClickLogout()"
        >
          <span class="icon">
            <i class="fas fa-envelope"></i>
          </span>
          <span>Logout</span>
        </a>

        <DeleteForm
          requestPath="/logout"
          ref="deleteSession"
        />
      </div>
    </div>
  </nav>
</template>

<script>
import DeleteForm from '../2_molecules/DeleteForm.vue';

export default {
  name: 'TheNavigation',

  components: {
    'DeleteForm': DeleteForm,
  },

  props: {
    currentUser: {
      type: Object
    }
  },

  data () {
    return {
      drawer: null,
    }
  },

  computed: {
    isLoggedIn () {
      return !!this.currentUser
    }
  },

  methods: {
    onClickMenu (path) {
      location.href = path;
    },
    onClickLogout () {
      console.log(this.$refs.deleteSession);
      this.$refs.deleteSession.$refs.form.submit()
    },
  }
}
</script>
