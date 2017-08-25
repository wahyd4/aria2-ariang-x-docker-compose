FROM nginx:alpine
MAINTAINER junv<wahyd4@gmail.com>

# For build image in local quickly
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apk update && apk add wget bash curl openrc screen aria2 tar --no-cache

COPY aria2.conf /root
COPY aria2c.sh /root

COPY nginx.conf /etc/nginx/nginx.conf
COPY conf.d/ /etc/nginx/conf.d/

RUN mkdir -p /usr/local/www && mkdir -p /usr/local/www/aria2

#AriaNg
RUN mkdir /usr/local/www/aria2/Download && cd /usr/local/www/aria2 \
 && wget -N --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/0.2.0/aria-ng-0.2.0.zip && unzip aria-ng-0.2.0.zip && rm -rf aria-ng-0.2.0.zip \
 && chmod -R 755 /usr/local/www/aria2 \
 && chmod +x /root/aria2c.sh

 # forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 6800 80

CMD ["sh", "/root/aria2c.sh" ]

