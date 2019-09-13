FROM ruby:2.5.1-alpine
LABEL maintainer "towerofl <towerofl@gmail.com>"

ENV APP_ROOT=/app \
  DEV_PACKAGES="git build-base less linux-headers libxml2-dev libxslt-dev tzdata openssl" \
  LANG="C.UTF-8" \
  RAILS_PACKAGES="postgresql-dev imagemagick"

# Install dependencies
RUN \
  set -x && \
  apk update && apk upgrade && apk add --no-cache $DEV_PACKAGES $RAILS_PACKAGES && \
  cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
  bundle config build.nokogiri --use-system-libraries

WORKDIR $APP_ROOT

CMD ["rails", "server", "-b", "0.0.0.0"]
