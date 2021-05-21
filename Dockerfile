FROM nginx:stable-alpine as builder

RUN set -ex \
    && apk update \
    && apk add linux-headers openssl-dev pcre-dev zlib-dev openssl abuild \
               musl-dev libxslt libxml2-utils make mercurial gcc unzip git \
               xz g++ \
    && printf "#!/bin/sh\\n/usr/bin/abuild -F \"\$@\"\\n" > /usr/local/bin/abuild \
    && chmod +x /usr/local/bin/abuild \
    && hg clone https://hg.nginx.org/pkg-oss/ \
    && cd pkg-oss \
    && mkdir /tmp/packages \
    && cd /pkg-oss/alpine \
    && make abuild-module-rtmp BASE_VERSION=$NGINX_VERSION NGINX_VERSION=$NGINX_VERSION \
    && apk add $(. ./abuild-module-rtmp/APKBUILD; echo $makedepends;) \
    && make module-rtmp BASE_VERSION=$NGINX_VERSION NGINX_VERSION=$NGINX_VERSION \
    && find ~/packages -type f -name "*.apk" -exec mv -v {} /tmp/packages/ \;

FROM nginx:stable-alpine

COPY --from=builder /tmp/packages /tmp/packages

RUN set -ex \
    && apk add --no-cache --allow-untrusted /tmp/packages/nginx-module-rtmp-${NGINX_VERSION}*.apk \
    && rm -rf /tmp/packages

COPY conf/* /etc/nginx
COPY html/* /usr/share/nginx/html

EXPOSE 1935
