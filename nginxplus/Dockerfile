FROM ubuntu:20.04

RUN mkdir -p /etc/ssl/nginx

COPY nginx-repo.crt /etc/ssl/nginx/nginx-repo.crt
COPY nginx-repo.key /etc/ssl/nginx/nginx-repo.key

RUN set -x \
    && chmod 644 /etc/ssl/nginx/* \
    && addgroup --system --gid 1001 nginx \
    && adduser --system --disabled-login --ingroup nginx --no-create-home --home /nonexistent --gecos "nginx user" --shell /bin/false --uid 1001 nginx \
    && apt-get update && apt-get upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq -y install --no-install-recommends apt-transport-https lsb-release ca-certificates wget dnsutils gnupg vim-tiny apt-utils \
    && wget http://nginx.org/keys/nginx_signing.key && apt-key add nginx_signing.key \
    && printf "deb https://plus-pkgs.nginx.com/ubuntu focal nginx-plus\n" | tee /etc/apt/sources.list.d/nginx-plus.list \
    && wget -P /etc/apt/apt.conf.d https://cs.nginx.com/static/files/90nginx \
    && apt-get update \
    && apt install vim \
    && apt-cache policy nginx-plus \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq -y install --no-install-recommends nginx-plus=23-1~focal  \
    nginx-plus-module-image-filter=23-1~focal \
    #nginx-plus-module-njs=23+0.5.2-1~focal \
    #nginx-ha-keepalived \
    #nginx-plus-module-geoip=23-1~focal \
    #nginx-plus-module-headers-more=23-1~focal \
    #nginx-plus-module-lua=23-1~focal \
    #nginx-plus-module-ndk=23-1~focal \
    #nginx-plus-module-passenger=23-1~focal \
    #nginx-plus-module-rtmp=23-1~focal \
    #nginx-sync \
    && mkdir -p /usr/share/nginx/html/images \
    && mkdir -p /var/cache/nginx \
    && chown -R nginx /var/cache/nginx \
    && mkdir -p /var/lib/nginx/state \
    && chown -R nginx /var/lib/nginx/state \
    && chown -R nginx:nginx /etc/nginx \
    && ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log \
    && ulimit -c -m -s -t unlimited \
    && apt-get remove --purge --auto-remove -y gnupg lsb-release apt-utils \  
    && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/nginx-plus.list \
    && rm -rf /etc/apt/apt.conf.d/90nginx \
    && rm -rf nginx_signing.key \
    && rm /etc/ssl/nginx/nginx-repo.crt /etc/ssl/nginx/nginx-repo.key

COPY 1.jpg 2.jpg 3.jpg /usr/share/nginx/html/images/
COPY nginx.conf /etc/nginx/
COPY default.conf /etc/nginx/conf.d/

EXPOSE 80 443 8080
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]