EntryPoint2019
====

[![CircleCI](https://circleci.com/gh/ofl/entry_point_2019.svg?style=svg)](https://circleci.com/gh/ofl/entry_point_2019)

Overview

Rails + GraphQL + Apollo Client + Atomic Design

## Description

## Demo

+   [Demo](https://obscure-stream-55714.herokuapp.com/)

## Requirement

### Ruby

+   [GraphQL](http://graphql-ruby.org/)
+   [sorcery](https://rubygems.org/gems/sorcery)

### JavaScript

+   [Apollo GraphQL](https://www.apollographql.com/)
+   [Vue.js](https://jp.vuejs.org/index.html)
+   [Buefy](https://buefy.github.io/)
+   [laravel-mix](https://github.com/JeffreyWay/laravel-mix)

### CSS

+   [Bulma](https://bulma.io/)

### Service

+   [Heroku](https://www.heroku.com/home)
+   [CircleCI](https://circleci.com/)

## Install

```
# bundle install
$ docker-compose run --rm rails bundle install

# yarn install
$ docker-compose run --rm yarn
```

## Usage

```
$ docker-compose up -d

# run watch
$ docker-compose run --rm yarn run watch
```

### Add npm package

```
$ docker-compose run --rm yarn add xxx
```

### Update gem

```
$ docker-compose run --rm rails bundle update
```

### Update package.json

```
$ ncu -u
```

### Update npm

```
$ docker-compose run --rm yarn upgrade
```

## Licence

[MIT](https://github.com/tcnksm/tool/blob/master/LICENCE)

## Author

[ofl](https://github.com/ofl)
