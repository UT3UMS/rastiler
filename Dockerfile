FROM openresty/openresty:alpine-fat

EXPOSE 8000
RUN apk add sqlite sqlite-dev lua-cjson
RUN /usr/local/openresty/luajit/bin/luarocks install sqlite3

# RUN /bin/bash -c "envsubst < /usr/local/openresty/nginx/conf/nginx.conf.template > /usr/local/openresty/nginx/conf/nginx.conf
# CMD nginx -g 'daemon off;'
