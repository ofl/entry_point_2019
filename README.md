# EntryPoint2019

[![CircleCI](https://circleci.com/gh/ofl/entry_point_2019.svg?style=svg)](https://circleci.com/gh/ofl/entry_point_2019)

Overview

Rails + Vue.js + GraphQL + Apollo Client + Atomic Design + Storybook

## Description

## Demo

- [Demo](https://obscure-stream-55714.herokuapp.com/)

## Requirement

### Ruby

- [GraphQL](http://graphql-ruby.org/)
- [sorcery](https://rubygems.org/gems/sorcery)

### JavaScript

- [Apollo GraphQL](https://www.apollographql.com/)
- [Vue.js](https://jp.vuejs.org/index.html)
- [Buefy](https://buefy.github.io/)
- [laravel-mix](https://github.com/JeffreyWay/laravel-mix)
- [Storybook](https://storybook.js.org/)

### CSS

- [Bulma](https://bulma.io/)

### Service

- [Heroku](https://www.heroku.com/home)
- [CircleCI](https://circleci.com/)

## Install

```shell
# bundle install
docker-compose run --rm rails bundle install

# yarn install
docker-compose run --rm yarn
```

## Usage

```shell
# Edit environment variables
cp .env.sample .env
```

```shell
docker-compose up -d

# run watch
docker-compose run --rm yarn run watch
```

### Javascript Lint

```shell
docker-compose run --rm yarn run lint
```

### Javascript Test(Jest)

```shell
docker-compose run --rm yarn run test
```

### Storybook

```shell
docker-compose run --rm --service-ports yarn run storybook
```

### Add npm package

```shell
docker-compose run --rm yarn add xxx
```

### Update gem

```shell
docker-compose run --rm rails bundle update
```

### Update package.json

```shell
ncu -u
```

### Update npm

```shell
docker-compose run --rm yarn upgrade
```

### Force Push

```shell
git push heroku feature/234_send_grid:master --force
```

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[ofl](https://github.com/ofl)
