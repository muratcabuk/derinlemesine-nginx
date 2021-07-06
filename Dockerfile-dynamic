FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ARG TZ=Europe/Istanbul

RUN apt update && apt install -y tzdata vim wget systemctl git \
                    geoip-database libgeoip-dev \ 
                    build-essential libpcre3 libpcre3-dev zlib1g zlib1g-dev \
                    libssl-dev libgd-dev libxml2 libxml2-dev uuid-dev

RUN mkdir /home/nginx

WORKDIR /home/nginx
RUN wget  http://nginx.org/download/nginx-1.20.0.tar.gz && tar -zxvf nginx-1.20.0.tar.gz

RUN git clone https://github.com/cubicdaiya/ngx_small_light.git
RUN git clone https://github.com/openresty/lua-nginx-module.git
RUN git clone https://github.com/limithit/NginxExecute.git
RUN git clone https://github.com/nbs-system/naxsi.git
RUN git clone https://github.com/arut/nginx-rtmp-module.git
RUN git clone https://github.com/wandenberg/nginx-selective-cache-purge-module.git
RUN git clone https://github.com/fdintino/nginx-upload-module.git
RUN git clone https://github.com/wandenberg/redis_nginx_adapter.git


WORKDIR nginx-1.20.0
RUN ./configure --prefix=/usr/sbin/nginx --sbin-path=/usr/sbin/nginx \
            --conf-path=/etc/nginx/nginx.conf \
            --http-log-path=/var/log/nginx/access.log \
            --error-log-path=/var/log/nginx/error.log \
            --lock-path=/var/lock/nginx.lock --pid-path=/run/nginx.pid \
            --modules-path=/usr/lib/nginx/modules \
            # standart static moduller
            --with-http_ssl_module --with-http_stub_status_module \
            --with-http_realip_module --with-http_auth_request_module \
            --with-http_v2_module --with-http_dav_module \
            --with-http_slice_module --with-threads \
            --with-http_addition_module --with-http_gunzip_module \
            --with-http_gzip_static_module --with-http_sub_module \
            --with-http_mp4_module --with-mail_ssl_module\
            --with-http_secure_link_module  --with-http_v2_module \
            --with-poll_module --with-threads --with-file-aio \
            --with-select_module  --with-http_secure_link_module \
            # standart dinamik modüller
            --with-mail=dynamic --with-stream=dynamic  \
            --with-http_geoip_module=dynamic \
            # Community static modüller
            --add-module=/home/nginx/naxsi/naxsi_src \
            --add-module=/home/nginx/nginx-rtmp-module \
            # community dinamik modüller
            --add-dynamic-module=/home/nginx/NginxExecute \
            --add-dynamic-module=/home/nginx/nginx-upload-module


RUN make && make install

RUN ln -s /usr/lib/nginx/modules /etc/nginx/modules

WORKDIR /usr/sbin/nginx/

EXPOSE 80

CMD /bin/bash -c "./nginx && tail -f /var/log/nginx/*.log"
