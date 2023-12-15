#!/bin/sh

HOST=${HOST:-'yourdomain.com'}
UUID=${UUID:-`cat /proc/sys/kernel/random/uuid`}
VMESS_WSPATH=${VMESS_WSPATH:-'/vmess'}
VLESS_WSPATH=${VLESS_WSPATH:-'/vless'}

sed -i "s|HOST|$HOST|g;s|UUID|$UUID|g;s|VMESS_WSPATH|$VMESS_WSPATH|g;s|VLESS_WSPATH|$VLESS_WSPATH|g" /usr/share/nginx/html/config.html
sed -i "s|HOST|$HOST|g;s|UUID|$UUID|g;s|VMESS_WSPATH|$VMESS_WSPATH|g;s|VLESS_WSPATH|$VLESS_WSPATH|g" /etc/v2ray/config.json
sed -i "s|HOST|$HOST|g;s|UUID|$UUID|g;s|VMESS_WSPATH|$VMESS_WSPATH|g;s|VLESS_WSPATH|$VLESS_WSPATH|g" /etc/nginx/nginx.conf

nginx

/usr/local/v2ray/v2ray run -config=/etc/v2ray/config.json
