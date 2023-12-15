FROM nginx:mainline-alpine-slim
EXPOSE 80
USER root

RUN apk update && apk add --no-cache supervisor wget unzip curl

ENV HOST test.com
ENV UUID de04add9-1234-abcd-950c-08cd5320df18
ENV VMESS_WSPATH /vmess
ENV VLESS_WSPATH /vless

COPY entrypoint.sh /entrypoint.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY nginx.conf /etc/nginx/nginx.conf
COPY config.html /usr/share/nginx/html/config.html

RUN mkdir /etc/v2ray /usr/local/v2ray
COPY config.json /etc/v2ray/

RUN wget -q -O /tmp/v2ray-linux-64.zip https://github.com/v2fly/v2ray-core/releases/download/v5.12.1/v2ray-linux-64.zip && \
    unzip -d /usr/local/v2ray /tmp/v2ray-linux-64.zip v2ray  && \
    wget -q -O /usr/local/v2ray/geosite.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geosite.dat && \
    wget -q -O /usr/local/v2ray/geoip.dat https://github.com/Loyalsoldier/v2ray-rules-dat/releases/latest/download/geoip.dat && \
    chmod a+x /entrypoint.sh && \
    apk del wget unzip  && \
    rm -rf /tmp/v2ray-linux-64.zip && \
    rm -rf /var/cache/apk/* && \
    rm -rf /tmp/*
    
ENTRYPOINT [ "/entrypoint.sh" ]
