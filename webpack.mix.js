let mix = require("laravel-mix");

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */

mix.webpackConfig({
  module: {
    rules: [
      {
        test: /\.(graphql|gql)$/,
        exclude: /node_modules/,
        loader: "graphql-tag/loader"
      }
    ]
  }
});

mix.extend(
  "i18n",
  new class {
    webpackRules() {
      return [
        {
          resourceQuery: /blockType=i18n/,
          type: "javascript/auto",
          loader: "@kazupon/vue-i18n-loader"
        }
      ];
    }
  }()
);

mix
  .setPublicPath("public")
  .i18n()
  .js("assets/js/app.js", "js")
  .sass("assets/sass/app.scss", "css");

if (mix.inProduction()) {
  mix.version();
} else {
  mix.sourceMaps().webpackConfig({ devtool: "source-map" });
}
