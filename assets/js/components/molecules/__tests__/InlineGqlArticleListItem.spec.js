import { shallowMount, RouterLinkStub } from "@vue/test-utils";
import InlineGqlArticleListItem from "../InlineGqlArticleListItem.vue";

describe("InlineGqlArticleListItem", () => {
  test("is a Vue instance", () => {
    const article = {
      id: "1",
      title: "Hello",
      body: "World",
      createdAt: "2019-01-01",
      commentsCount: 1,
      likesCount: 1,
      user: {
        id: "1",
        name: "Jhon",
        avatar: "https://foo.com/br.png"
      }
    };

    const wrapper = shallowMount(InlineGqlArticleListItem, {
      propsData: { article },
      stubs: { RouterLink: RouterLinkStub }
    });
    expect(wrapper.isVueInstance()).toBeTruthy();
  });
});
