<template>
  <div class="hero-body">
    <div class="container has-text-centered">
      <div class="column is-4 is-offset-4">
        <h3 class="title has-text-grey">Sign Up</h3>
        <p class="subtitle has-text-grey">Please sign up.</p>
        <div class="box">
          <figure class="avatar">
            <img src="https://placehold.it/128x128" >
          </figure>
          <SignUpForm1
            v-if="step === 1"
            :user="user"
            :step="step"
            @next="next"
          />
          <SignUpForm2
            v-if="step === 2"
            :user="user"
            :step="step"
            @next="next"
            @back="back"
          />
          <SignUpForm3
            v-if="step === 3"
            :user="user"
            :step="step"
            @next="next"
            @back="back"
          />
          <SignUpForm4
            v-if="step === 4"
            :user="user"
            :step="step"
          />
        </div>
        <p class="has-text-grey">
          <a href="./login"> Login </a> &nbsp;·&nbsp;
        </p>
      </div>
    </div>
  </div>
</template>

<script>
import SignUpForm1 from "../organisms/SignUpForm1.vue";
import SignUpForm2 from "../organisms/SignUpForm2.vue";
import SignUpForm3 from "../organisms/SignUpForm3.vue";
import SignUpForm4 from "../organisms/SignUpForm4.vue";

export default {
  name: "SignUpContent",

  components: { SignUpForm1, SignUpForm2, SignUpForm3, SignUpForm4 },

  data() {
    return {
      step: 1,
      user: {
        name: "",
        email: "",
        password: ""
      }
    };
  },

  methods: {
    submit() {

    },
    next() {
      this.step++;
    },
    back() {
      this.step--;
    }
  }
};
</script>

<style scoped>
.box {
  margin-top: 5rem;
}
.avatar {
  margin-top: -70px;
  padding-bottom: 20px;
}
.avatar img {
  padding: 5px;
  background: #fff;
  border-radius: 50%;
  -webkit-box-shadow: 0 2px 3px rgba(10, 10, 10, 0.1),
    0 0 0 1px rgba(10, 10, 10, 0.1);
  box-shadow: 0 2px 3px rgba(10, 10, 10, 0.1), 0 0 0 1px rgba(10, 10, 10, 0.1);
}
input {
  font-weight: 300;
}
p.subtitle {
  padding-top: 1rem;
}
</style>
