FROM nginx:mainline-alpine-slim
EXPOSE 80
USER root

ENV HOST test.com
ENV UUID de04add9-1234-abcd-950c-08cd5320df18
ENV VMESS_WSPATH /vmess
ENV VLESS_WSPATH /vless

RUN mkdir /etc/v2ray /usr/local/v2ray

COPY nginx.conf /etc/nginx/nginx.conf
COPY config.html /usr/share/nginx/html/config.html
COPY config.json /etc/v2ray/
COPY v2ray /usr/local/v2ray/
COPY entrypoint.sh /entrypoint.sh

RUN  chmod a+x /usr/local/v2ray/v2ray && \
     chmod a+x /entrypoint.sh
    
ENTRYPOINT ["/entrypoint.sh"]
