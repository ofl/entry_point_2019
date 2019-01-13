import { createLocalVue, shallowMount } from "@vue/test-utils";
import ArticleDetailCard from "../ArticleDetailCard.vue";
import Buefy from "buefy";
import { fakeArticle, fakeUser } from "../../../test/fake-data";

describe("ArticleDetailCard", () => {
  let localVue;
  beforeEach(() => {
    localVue = createLocalVue();
    localVue.use(Buefy, {});
  });

  test("is a Vue instance", () => {
    const wrapper = shallowMount(ArticleDetailCard, {
      localVue,
      propsData: { article: fakeArticle, currentUser: fakeUser }
    });

    expect(wrapper.isVueInstance()).toBeTruthy();
  });

  test("renders an article", () => {
    const wrapper = shallowMount(ArticleDetailCard, {
      localVue,
      propsData: { article: fakeArticle }
    });

    expect(wrapper.find("p.title.is-4").text()).toBe(fakeArticle.title);
  });
});
