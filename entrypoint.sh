#!/bin/bash

set -e

if [ -z "$webhook_url" ]; then
    echo "No webhook_url configured"
    exit 1
fi

if [ -n "$data" ]; then
    CUSTOM_JSON_DATA=$(echo -n "$data" | jq -c '')
    JSON_WITH_OPEN_CLOSE_BRACKETS_STRIPPED=`echo "$WEBHOOK_DATA" | sed 's/^{\(.*\)}$/\1/'`
    WEBHOOK_DATA="{$JSON_WITH_OPEN_CLOSE_BRACKETS_STRIPPED,\"data\":$CUSTOM_JSON_DATA}"
fi

WEBHOOK_ENDPOINT=$webhook_url

if [ -n "$webhook_auth" ]; then
    WEBHOOK_ENDPOINT="-u $webhook_auth $webhook_url"
fi


curl -X POST \
    -H "Content-Type: $CONTENT_TYPE" \
    -H "User-Agent: User-Agent: GitHub-Hookshot/760256b" \
    -H "X-GitHub-Delivery: $GITHUB_RUN_NUMBER" \
    -H "X-GitHub-Event: $GITHUB_EVENT_NAME" \
    --data "$WEBHOOK_DATA" $WEBHOOK_ENDPOINT
