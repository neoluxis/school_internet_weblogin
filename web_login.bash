#!/bin/bash

#TEST_URL="https://www.google.cn/generate_204"
TEST_URL="https://captive.apple.com"
TIME_OUT=5

ACCOUNT=$(cat ./account)
PASSWD=$(cat ./password)
WLAN_USER_IP=$(ip address show dev wlan0 | grep "inet " | awk '{print $2}' | cut -d/ -f1)

web_login() {
    echo "$(date): Curl web login"

  curl "http://10.4.66.2:801/eportal/portal/login?callback=dr1003&login_method=1&user_account=%2C0%2C${ACCOUNT}%40cmcc&user_password=${PASSWD}&wlan_user_ip=${WLAN_USER_IP}&wlan_user_ipv6=&wlan_user_mac=000000000000&wlan_ac_ip=&wlan_ac_name=&jsVersion=4.2.1&terminal_type=1&lang=en&v=8636&lang=en" \
  -H 'Accept: */*' \
  -H 'Accept-Language: en-US,en;q=0.9,zh-CN;q=0.8,zh;q=0.7,ko-KR;q=0.6,ko;q=0.5,ja-JP;q=0.4,ja;q=0.3' \
  -H 'Connection: keep-alive' \
  -H 'Referer: http://10.4.66.2/' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36' \
  --insecure
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

HTTP_CODE=$(curl -I --max-time 5 -o /dev/null -s -w "%{http_code}" "$TEST_URL")

if [ "$HTTP_CODE" = "204" ] || [ "$HTTP_CODE" = "200" ]; then
    echo "Connected to internet"
    exit 0
fi

if echo "$HTTP_CODE" | grep -qE '^30'; then
    echo "$(date): Redirect"
    exit 1
fi
