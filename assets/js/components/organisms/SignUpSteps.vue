<template>
  <div class="steps" id="stepsDemo">
    <div
      class="step-item"
      v-bind:class="{ 'is-active': isActive(1), 'is-success': isSuccess(1), 'is-completed': isCompleted(1) }"
    >
      <div class="step-marker">1</div>
      <div class="step-details">
        <p class="step-title">Name</p>
      </div>
    </div>
    <div
      class="step-item"
      v-bind:class="{ 'is-active': isActive(2), 'is-success': isSuccess(2), 'is-completed': isCompleted(2) }"
    >
      <div class="step-marker">2</div>
      <div class="step-details">
        <p class="step-title">Email/Password</p>
      </div>
    </div>
    <div
      class="step-item"
      v-bind:class="{ 'is-active': isActive(3), 'is-success': isSuccess(3), 'is-completed': isCompleted(3) }"
    >
      <div class="step-marker">3</div>
      <div class="step-details">
        <p class="step-title">Confirmation</p>
      </div>
    </div>
    <div
      class="step-item"
      v-bind:class="{ 'is-active': isActive(4), 'is-success': isSuccess(4), 'is-completed': isCompleted(4) }"
    >
      <div class="step-marker">4</div>
      <div class="step-details">
        <p class="step-title">Done</p>
      </div>
    </div>
  </div>
</template>

<script>
import 'bulma-extensions/bulma-steps/dist/css/bulma-steps.min.css'

export default {
  name: "SignUpSteps",

  props: {
    step: {
      type: Number
    }
  },

  methods: {
    isActive(num) {
      return num == this.step;
    },
    isSuccess(num) {
      return num <= this.step;
    },
    isCompleted(num) {
      return num < this.step;
    },
  }
};
</script>

<style scoped>
.step-title {
  color: #4a4a4a;
}
</style>
