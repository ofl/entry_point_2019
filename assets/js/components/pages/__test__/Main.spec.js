import { shallowMount } from "@vue/test-utils";
import Main from "../Main.vue";

describe("Main", () => {
  test("is a Vue instance", () => {
    const route = mainRoute();

    const wrapper = shallowMount(Main, {
      mocks: {
        $route: route,
        $t: msg => msg,
        $rails: {}
      },

      stubs: {
        MainContent: "<div>Main</div>"
      }
    });

    expect(wrapper.isVueInstance()).toBeTruthy();
  });
});

const mainRoute = () => ({
  path: "/"
});
