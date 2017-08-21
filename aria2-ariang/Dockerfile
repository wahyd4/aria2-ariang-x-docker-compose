FROM zzrot/alpine-caddy

RUN apk update && apk add wget bash curl openrc screen aria2 tar --no-cache


COPY aria2.conf /root
COPY aria2c.sh /root

# 安装Caddy成功后，继续新建一个虚拟主机文件夹， 写入配置到 Caddy 配置文件，注意下面这五行要一起复制粘贴，不是一行一行复制！
RUN mkdir -p /usr/local/caddy/www && mkdir -p /usr/local/caddy/www/aria2 && echo -e " 0.0.0.0:80  \n \
 root /usr/local/caddy/www/aria2 \n \
 timeouts none \n \
 gzip \n \
 browse \n \
" > /usr/local/caddy/Caddyfile


# 下载并解压 AriaNg 文件，这段代码会自动检测并下载最新版本
# 如果上面自动检测最新版本的代码返回空白或者错误，那么请访问 https://github.com/mayswind/AriaNg/releases/latest 来查看最新版本号。
# 例如手动获取的版本号是 0.1.0，那么手动执行命令： Ver="0.1.0" ，然后继续下面步骤即可。
#AriaNg
RUN mkdir /usr/local/caddy/www/aria2/Download && cd /usr/local/caddy/www/aria2 \
 && wget -N --no-check-certificate https://github.com/mayswind/AriaNg/releases/download/0.2.0/aria-ng-0.2.0.zip && unzip aria-ng-0.2.0.zip && rm -rf aria-ng-0.2.0.zip \
 && chmod -R 755 /usr/local/caddy/www/aria2 \
 && chmod +x /root/aria2c.sh

EXPOSE 6800 80


# CMD ["service", "caddy", "start"]
# ENTRYPOINT ["top", "-n", "10"]
# CMD ["caddy", "-quic", "--conf", "/usr/local/caddy/Caddyfile"]
CMD ["sh", "/root/aria2c.sh" ]

