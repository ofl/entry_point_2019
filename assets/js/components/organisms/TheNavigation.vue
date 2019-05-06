<template>
  <nav
    class="navbar is-link is-fixed-top"
    role="navigation"
    aria-label="main navigation"
  >
    <div class="navbar-brand">
      <a class="navbar-item"
href="/">
        <img
          src="https://bulma.io/images/bulma-logo.png"
          width="112"
          height="28"
        />
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
        <span aria-hidden="true" /> <span aria-hidden="true" />
        <span aria-hidden="true" />
      </a>
    </div>

    <div
      id="navbarExampleTransparentExample"
      class="navbar-menu"
      :class="{ 'is-active': isActive }"
    >
      <div class="navbar-end">
        <a class="navbar-item"
href="#" @click.stop.prevent="onClickMenu('/')">
          <span class="icon"> <i class="fas fa-home" /> </span>
          <span>Home</span>
        </a>

        <div class="navbar-item has-dropdown is-hoverable">
          <a class="navbar-link"> Articles </a>

          <div class="navbar-dropdown">
            <RouterLink to="/inline_gql_articles"
class="navbar-item">
              <span class="icon"> <i class="fas fa-file-alt" /> </span>
              <span>Articles(Inline+GQL)</span>
            </RouterLink>
            <RouterLink to="/gql_articles"
class="navbar-item">
              <span class="icon"> <i class="fas fa-file-alt" /> </span>
              <span>Articles(GQL)</span>
            </RouterLink>
            <a
              class="navbar-item"
              href="/vue_articles"
              @click.stop.prevent="onClickMenu('/vue_articles')"
            >
              <span class="icon"> <i class="fas fa-file-alt" /> </span>
              <span>Articles(Inline)</span>
            </a>
            <a
              class="navbar-item"
              href="/articles"
              @click.stop.prevent="onClickMenu('/articles')"
            >
              <span class="icon"> <i class="fas fa-file-alt" /> </span>
              <span>Articles(Rails)</span>
            </a>
          </div>
        </div>

        <a
          v-if="!isLoggedIn"
          class="navbar-item"
          href="#"
          @click.stop.prevent="onClickMenu('/login')"
        >
          <span class="icon"> <i class="fas fa-sign-in-alt" /> </span>
          <span>Login</span>
        </a>

        <div v-if="isLoggedIn" class="navbar-item has-dropdown is-hoverable">
          <a class="navbar-link"> {{ currentUser.name }} </a>

          <div class="navbar-dropdown">
            <RouterLink to="/profile/edit"
class="navbar-item">
              <span class="icon"> <i class="fas fa-file-alt" /> </span>
              <span>Edit Profile</span>
            </RouterLink>

            <a
              class="navbar-item"
              href="#"
              @click.stop.prevent="confirmLogout()"
            >
              <span class="icon"> <i class="fas fa-sign-out-alt" /> </span>
              <span>Logout</span>
            </a>

            <DeleteForm ref="deleteSession"
request-path="/logout" />
          </div>
        </div>
      </div>
    </div>
  </nav>
</template>

<script>
import DeleteForm from "../molecules/DeleteForm.vue";

export default {
  name: "TheNavigation",

  components: { DeleteForm },

  props: {
    currentUser: {
      type: Object
    }
  },

  data() {
    return {
      isActive: false
    };
  },

  computed: {
    isLoggedIn() {
      return !!this.currentUser;
    }
  },

  methods: {
    onClickMenu(path) {
      location.href = path;
    },

    toggleMenu() {
      this.isActive = !this.isActive;
    },

    confirmLogout() {
      this.$dialog.confirm({
        message: "Are you sure?",
        onConfirm: () => this.logout()
      });
    },

    logout() {
      this.deleteApolloCacheData();
      this.$refs.deleteSession.$refs.form.submit();
    },

    deleteApolloCacheData() {
      this.$apollo.provider.defaultClient.resetStore();
    }
  }
};
</script>
