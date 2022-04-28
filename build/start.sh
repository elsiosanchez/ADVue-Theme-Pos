#!/usr/bin/env sh
# @autor Edwin Betancourt <EdwinBetanc0urt@outlook.com>
# Set enviroment variables to config file default.json and ecosystem.json

# Set env values to proxy api rest ful
sed -i "s|SERVER_HOST|$(hostname)|g" $REPOSITORY_PATH/config/default.json
sed -i "s|SERVER_PORT|$SERVER_PORT|g" $REPOSITORY_PATH/config/default.json
sed -i "s|API_URL|$API_URL|g"  $REPOSITORY_PATH/config/default.json
sed -i "s|STORE_INDEX|$STORE_INDEX|g" $REPOSITORY_PATH/config/default.json
sed -i "s|MEMORY_RESTART|$MEMORY_RESTART|g" $REPOSITORY_PATH/ecosystem.json
sed -i "s|EXEC_INSTANCES|$EXEC_INSTANCES|g" $REPOSITORY_PATH/ecosystem.json


cd /var/www/adempiere-vue

# Run app
yarn run build && yarn run start && tail -f /dev/null
