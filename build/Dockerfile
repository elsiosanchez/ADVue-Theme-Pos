
FROM node:12-alpine

LABEL maintainer="EdwinBetanc0urt@EdwinBetanc0urt.com" \
	description="ERPYA e-Commerce"


# Init ENV with default values
ENV VS_ENV=prod \
	REPOSITORY_PATH="/var/www/vue-storefront" \
	REPOSITORY_NAME="vue-storefront" \
	URL_BASE_REPOSITORY="https://github.com/erpcya/vue-storefront-1.git" \
	URL_THEME_REPOSITORY="https://github.com/elsiosanchez/ADVue-Theme-Pos.git" \
	SERVER_PORT="3000" \
	SERVER_HOST="localhost" \
	API_URL="http:\/\/localhost:8085" \
	STORE_INDEX="vue_storefront_catalog" \
	MEMORY_RESTART="1G" \
	EXEC_INSTANCES="1"


# Add system dependencies
RUN rm -rf /var/cache/apk/* \
	&& apk add --no-cache --virtual .build-deps \
		ca-certificates \
		wget \
		python3 \
		make \
		g++ \
		unzip \
		curl \
	&& apk add --no-cache \
		git \
		# yarn \
	&& apk --no-cache --update upgrade musl \
	&& yarn global add lerna \
	&& ls

# Copy src files
COPY dist-app/ /var/www/ADVue-Theme-Pos/
#COPY build/start.sh /var/www/proxy-adempiere-api/start.sh
#COPY dist-app/ /var/www/proxy-adempiere-api/

RUN echo "Downloading ... $URL_BASE_REPOSITORY to $REPOSITORY_PATH" && \
	git clone $URL_BASE_REPOSITORY $REPOSITORY_PATH && \
	&& yarn install --no-cache \
	cd $REPOSITORY_PATH && \
	yarn global add lerna && \
	git submodule add /var/www/ADVue-Theme-Pos ./src/themes/erpya && \
	git submodule update --init ./src/themes/erpya && \
	lerna bootstrap && \
	chmod -R 777 $REPOSITORY_PATH

# Copy Default files
COPY build/default.json $REPOSITORY_PATH/config/
COPY build/ecosystem.json $REPOSITORY_PATH
COPY build/start.sh $REPOSITORY_PATH

WORKDIR $REPOSITORY_PATH

# Start app
CMD	'sh' 'start.sh'
