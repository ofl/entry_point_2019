<template>
  <nav class="navbar is-link is-fixed-top" role="navigation" aria-label="main navigation">
    <div class="navbar-brand">
      <a class="navbar-item" href="/">
        <img src="https://bulma.io/images/bulma-logo.png" width="112" height="28">
      </a>
      <a
        role="button"
        class="navbar-burger burger"
        :class="{ 'is-active': isActive }"
        aria-label="menu"
        aria-expanded="false"
        data-target="navbarExampleTransparentExample"
        @click="toggleMenu()"
      >
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
        <span aria-hidden="true"></span>
      </a>
    </div>

    <div
      id="navbarExampleTransparentExample"
      class="navbar-menu"
      :class="{ 'is-active': isActive }"
    >
      <div class="navbar-end">
        <a
          class="navbar-item"
          href="#"
          @click.stop.prevent="onClickMenu('/')"
        >
          <span class="icon">
            <i class="fas fa-home"></i>
          </span>
          <span>Home</span>
        </a>

        <div class="navbar-item has-dropdown is-hoverable">
          <a class="navbar-link">
            Articles
          </a>

          <div class="navbar-dropdown">
            <a
              class="navbar-item"
              href="/spa_articles"
              @click.stop.prevent="onClickMenu('/spa_articles')"
            >
              <span class="icon">
                <i class="fas fa-file-alt"></i>
              </span>
              <span>SPA Articles</span>
            </a>
            <a
              class="navbar-item"
              href="/vue_articles"
              @click.stop.prevent="onClickMenu('/vue_articles')"
            >
              <span class="icon">
                <i class="fas fa-file-alt"></i>
              </span>
              <span>Vue Articles</span>
            </a>
            <a
              class="navbar-item"
              href="/articles"
              @click.stop.prevent="onClickMenu('/articles')"
            >
              <span class="icon">
                <i class="fas fa-file-alt"></i>
              </span>
              <span>Articles</span>
            </a>
          </div>
        </div>

        <a
          v-if=!isLoggedIn
          class="navbar-item"
          href="#"
          @click.stop.prevent="onClickMenu('/login')"
        >
          <span class="icon">
            <i class="fas fa-sign-in-alt"></i>
          </span>
          <span>Login</span>
        </a>
        <a
          v-if=isLoggedIn
          class="navbar-item"
          href="#"
          @click.stop.prevent="confirmLogout()"
        >
          <span class="icon">
            <i class="fas fa-sign-out-alt"></i>
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
      isActive: false,
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
    toggleMenu () {
      this.isActive = !this.isActive;
    },
    confirmLogout () {
      this.$dialog.confirm({
        message: 'Are you sure?',
        onConfirm: () => this.logout()
      })
    },
    logout () {
      this.$refs.deleteSession.$refs.form.submit()
    },
  }
}
</script>
