#!/bin/bash

#TEST_URL="https://www.google.cn/generate_204"
TEST_URL="https://captive.apple.com"
TIME_OUT=5

web_login() {
    echo "$(date): Curl web login"

    # Copy your curl cmd here
    curl ***
}

HTTP_CODE=$(curl -I --max-time 5 -o /dev/null -s -w "%{http_code}" "$TEST_URL")

if [ "$HTTP_CODE" = "204" ] || [ "$HTTP_CODE" = "200" ]; then
    echo "Connected to internet"
    exit 0
fi

if echo "$HTTP_CODE" | grep -qE '^30'; then
    echo "$(date): Redirect"
    web_login
    exit 1
fi

echo "$(date): Other status code ($HTTP_CODE)"
web_login
