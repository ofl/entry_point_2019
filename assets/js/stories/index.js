import { storiesOf } from "@storybook/vue";
import StoryRouter from "storybook-vue-router";

import InlineGqlArticleListItem from "../components/molecules/InlineGqlArticleListItem.vue";
import { fakeArticle } from "../test/fake-data";

storiesOf("InlineGqlArticleListItem", module)
  .addDecorator(StoryRouter())
  .add("simple", () => ({
    components: { InlineGqlArticleListItem },
    template: `<InlineGqlArticleListItem :article="article" />`,
    data() {
      return {
        article: fakeArticle
      };
    }
  }));
