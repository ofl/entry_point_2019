import { shallowMount, RouterLinkStub } from "@vue/test-utils";
import InlineGqlArticleListItem from "../InlineGqlArticleListItem.vue";
import { fakeArticle } from "../../../test/fake-data";

describe("InlineGqlArticleListItem", () => {
  test("is a Vue instance", () => {
    const wrapper = shallowMount(InlineGqlArticleListItem, {
      propsData: { article: fakeArticle },
      stubs: { RouterLink: RouterLinkStub }
    });

    expect(wrapper.isVueInstance()).toBeTruthy();
  });

  test("renders an article", () => {
    const wrapper = shallowMount(InlineGqlArticleListItem, {
      propsData: { article: fakeArticle },
      stubs: { RouterLink: RouterLinkStub }
    });

    expect(wrapper.find("h4").text()).toBe(fakeArticle.title);
  });

  test("renders an article", () => {
    const wrapper = shallowMount(InlineGqlArticleListItem, {
      propsData: { article: fakeArticle },
      stubs: { RouterLink: RouterLinkStub }
    });

    expect(wrapper.element).toMatchSnapshot();
  });

  test("avatarUrl is article author avatar url", () => {
    const wrapper = shallowMount(InlineGqlArticleListItem, {
      propsData: { article: fakeArticle },
      stubs: { RouterLink: RouterLinkStub }
    });

    expect(wrapper.vm.avatarUrl).toBe(fakeArticle.user.avatarUrl);
  });
});
