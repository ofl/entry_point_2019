FROM node:12.6-alpine
LABEL maintainer "towerofl <towerofl@gmail.com>"

ENV DEV_PACKAGES="curl build-base libpng-dev lcms2-dev bash"

WORKDIR /app

RUN \
  set -x && \
  apk update && \
  apk add git && \
  apk add --no-cache $DEV_PACKAGES && \
  curl -o- -L https://yarnpkg.com/install.sh | sh

ENV PATH $HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH

ENTRYPOINT ["yarn"]
