import { configure } from "@storybook/vue";

import Vue from "vue";

function loadStories () {
  require("./../assets/js/stories");
}

configure(loadStories, module);
