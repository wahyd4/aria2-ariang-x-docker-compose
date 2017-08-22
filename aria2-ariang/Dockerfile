FROM zzrot/alpine-caddy
MAINTAINER junv<wahyd4@gmail.com>

RUN apk update && apk add wget bash curl openrc screen aria2 tar --no-cache

COPY aria2.conf /root
COPY aria2c.sh /root

# install caddy
RUN mkdir -p /usr/local/caddy/www && mkdir -p /usr/local/caddy/www/aria2 && echo -e " 0.0.0.0:80  \n \
 root /usr/local/caddy/www/aria2 \n \
 timeouts none \n \
 gzip \n \
 browse \n \
" > /usr/local/caddy/Caddyfile

#AriaNg
RUN mkdir /usr/local/caddy/www/aria2/Download && cd /usr/local/caddy/www/aria2 \
 && wget -N --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/0.2.0/aria-ng-0.2.0.zip && unzip aria-ng-0.2.0.zip && rm -rf aria-ng-0.2.0.zip \
 && chmod -R 755 /usr/local/caddy/www/aria2 \
 && chmod +x /root/aria2c.sh

EXPOSE 6800 80

CMD ["sh", "/root/aria2c.sh" ]

