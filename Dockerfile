FROM nginx:mainline-alpine-slim
USER root

EXPOSE 80

ENV HOST test.com
ENV UUID de04add9-1234-abcd-950c-08cd5320df18
ENV VMESS_WSPATH /vmess
ENV VLESS_WSPATH /vless

RUN mkdir /usr/local/v2ray /etc/v2ray

COPY v2ray /usr/local/v2ray/
COPY config.json /etc/v2ray/
COPY nginx.conf /etc/nginx/nginx.conf
COPY config.html /usr/share/nginx/html/config.html
COPY entrypoint.sh /entrypoint.sh

RUN  chmod +x /usr/local/v2ray/v2ray && \
     chmod +x /entrypoint.sh
    
ENTRYPOINT ["/entrypoint.sh"]
