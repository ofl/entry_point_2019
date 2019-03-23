<template>
  <div class="container"><EditProfileForm :profile="currentUser" /></div>
</template>

<script>
import EditProfileForm from "../organisms/EditProfileForm.vue";

export default {
  name: "EditProfileContent",

  components: { EditProfileForm },

  props: {
    currentUser: {
      type: Object
    }
  }
};
</script>
