FROM node:12-alpine

LABEL maintainer="elsiosanchez@gmail.com" \
	description="ADVue-Theme-Pos"

# Init ENV with default values
ENV VS_ENV=prod \
    REPOSITORY_PATH="/var/www/adempiere-vue" \
    REPOSITORY_NAME="adempiere-vue" \
    URL_BASE_REPOSITORY="git@github.com:adempiere/adempiere-vue.git" \
		URL_THEME_REPOSITORY="git@github.com:elsiosanchez/ADVue-Theme-Pos.git" \
    SERVER_PORT="0527" \
    SERVER_HOST="localhost" \
    API_URL="http:\/\/localhost:8085" \
    # STORE_INDEX="vue_storefront_catalog" \
    MEMORY_RESTART="1G" \
    EXEC_INSTANCES="1"

COPY dist-app/ /var/www/ADVue-Theme-Pos/

RUN rm -rf /var/cache/apk/* && \
  apk add --no-cache --virtual .build-deps ca-certificates wget python3 make g++ \
  && apk add --no-cache git \
  && yarn install --no-cache \
  && apk del .build-deps && \
    apk --no-cache --update upgrade musl && \
    apk add --no-cache \
                --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
                --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
                --virtual .build-deps \
     unzip \
     curl && \
     echo "Downloading ... $URL_BASE_REPOSITORY to $REPOSITORY_PATH" && \
     git clone $URL_BASE_REPOSITORY $REPOSITORY_PATH && \
     cd $REPOSITORY_PATH && \
	 yarn global add lerna && \
     git submodule add /var/www/ADVue-Theme-Pos ./src/themes/pos && \
     git submodule update --init ./src/themes/pos && \
     lerna bootstrap && \
     chmod -R 777 $REPOSITORY_PATH

# Copy Default files
COPY build/default.json $REPOSITORY_PATH/config/
COPY build/ecosystem.json $REPOSITORY_PATH
COPY build/start.sh $REPOSITORY_PATH

WORKDIR $REPOSITORY_PATH

# Start app
CMD	'sh' 'start.sh'
