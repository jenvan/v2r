#!/bin/sh

HOST=${HOST:-test.com}
UUID=${UUID:-`cat /proc/sys/kernel/random/uuid`}
VMESS_WSPATH=${VMESS_WSPATH:-'/vm'}
VLESS_WSPATH=${VLESS_WSPATH:-'/vl'}
VMESS_LINK=$(echo -e '\x76\x6d\x65\x73\x73')://$(echo -n "{\"v\":\"2\",\"ps\":\"bing.com\",\"add\":\"$HOST\",\"port\":\"443\",\"id\":\"$UUID\",\"aid\":\"0\",\"net\":\"ws\",\"type\":\"none\",\"host\":\"$HOST\",\"path\":\"$VMESS_WSPATH\",\"tls\":\"tls\"}" | base64 -w 0)
VLESS_LINK=$(echo -e '\x76\x6c\x65\x73\x73')"://"$UUID"@"$HOST":443?encryption=none&security=tls&type=ws&host="$HOST"&path="$VLESS_WSPATH"#bing.com"

sed -i "s|VMESS_LINK|$VMESS_LINK|g;s|VLESS_LINK|$VLESS_LINK|g" /usr/share/nginx/html/config.html
sed -i "s|UUID|$UUID|g;s|VMESS_WSPATH|$VMESS_WSPATH|g;s|VLESS_WSPATH|$VLESS_WSPATH|g" /etc/v2ray/config.json
sed -i "s|UUID|$UUID|g;s|VMESS_WSPATH|$VMESS_WSPATH|g;s|VLESS_WSPATH|$VLESS_WSPATH|g" /etc/nginx/nginx.conf

nginx

/usr/local/v2ray/v2ray run -config=/etc/v2ray/config.json
