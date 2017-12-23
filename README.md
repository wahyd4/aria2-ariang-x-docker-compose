# Aria2-AriaNg-X docker-compose

中文 | [English](https://github.com/wahyd4/aria2-ariang-x-docker-compose/blob/master/README.en.md)

<!-- TOC -->

- [Aria2-AriaNg-X docker-compose](#aria2-ariang-x-docker-compose)
  - [应用截图](#应用截图)
  - [为什么会有这个东西](#为什么会有这个东西)
  - [比较 Filerun， h5ai 和 Nextcloud](#比较-filerun-h5ai-和-nextcloud)
  - [安装与使用](#安装与使用)
  - [升级](#升级)
  - [高级特性](#高级特性)
  - [找到你下载的文件](#找到你下载的文件)
  - [只想运行一个镜像？(如：在群晖中运行)](#只想运行一个镜像如在群晖中运行)
  - [常见问题](#常见问题)
  - [感谢](#感谢)

<!-- /TOC -->

这个项目是提供一个 docker-compose文件，让你可以一步就拥有一个集图形化界面的 Aria2下载（[AriaNg](https://github.com/mayswind/AriaNg)）和在线预览和管理文件的平台：
  * [FileRun](https://www.filerun.com/)
  * [Nextcloud](https://nextcloud.com/)
  * [h5ai](https://larsjung.de/h5ai/)


## 应用截图
 * AriaNg ![AriaNg](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/ariang.png)
 * Filerun ![filerun](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/filerun.png)
 * h5ai ![h5ai](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/h5ai.png)
 * nextcloud ![nextcloud](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud.png)

## 为什么会有这个东西
  * 使用 Docker-compose 让每个 docker 镜像只做一件事，则其本身会更加稳定，不易受其他组件的影响，也更方便管理
  * AriaNg 着实比之前的 Aria2 之前的其他图形化界面程序漂亮了太多。让人很喜欢。
  * 在线查看，预览下载的文件，让我们自己在自己 vps 上就可以拥有某些在线服务商提供的离线下载（迅雷、115）这样的功能。而且所有的控制权都在你手里，不用担心被删除资源

## 比较 Filerun， h5ai 和 Nextcloud

|比较类别 | Filerun | Nextcloud | h5ai|
|---- | --- | --- | --- |
|Docker 镜像大小| 226M | 104M | 21M |
|是否轻量级| 轻量级 | 也比较轻量级 | 轻量级 |
|功能| 功能少 | 功能强大 | 功能少 |
|UI| 简洁 | 精美 | 简洁 |
|依赖| 必须要Mysql数据库 | 可以直接使用 内嵌SQLlite，也可以使用其他外置数据库 | 无数据库 |
|集成难度|全自动，无需人工操作|需要人工操作两步| 全自动 |
|客户端|无|有移动和桌面客户端| 无|
|登录安全|支持用户名密码登录|支持用户名密码登录| 无|
|容器数量|mysql, filerun, aria2|nextcloud, aria2| h5ai, aria2 |
|总结|轻量级|功能全面，本身可以作为一个很好的云盘使用| 仅提供文件列表，和查看文件，播放音视频文件功能 |


## 安装与使用

  *提示* 如果你不是在本地安装，请记得替换 localhost 为你的 ip 或者绑定的域名哦！！

  1. 安装 Docker CE (社区版)，不要使用 Ubuntu 等操作系统系统自带的安装包来安装，因为他们的版本都很老了。推荐使用[官方提供](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)的方式安装

  2. 安装 Docker Compose <https://docs.docker.com/compose/install/#install-compose>
  #### 使用 **h5ai** 作为在线文件查看和播放
  ```bash
    git clone https://github.com/wahyd4/aria2-ariang-x-docker-compose.git
    cd aria2-ariang-x-docker-compose/h5ai
    docker-compose up -d
  ```
  搞定！

  1. 查看文件h5ai： <http://localhost:8000>

  2. AriaNg： <http://localhost:8000/aria2/> 注意地址后面一定要带`/` 哦，后面两种方案的也是一样
  ####  使用 **Filerun** 作为在线文件管理器
  ```bash
    git clone https://github.com/wahyd4/aria2-ariang-x-docker-compose.git
    cd aria2-ariang-x-docker-compose/filerun
    docker-compose up -d
  ```
  一切搞定，尽情享受吧！

  1. 文件管理Filerun, 请使用 `superuser / superuser` 进行登录： <http://localhost:8000>

  2. AriaNg： <http://localhost:8000/aria2/>

  #### 使用 **Nextcloud** 安装
  ```bash
    git clone https://github.com/wahyd4/aria2-ariang-x-docker-compose.git
    cd aria2-ariang-x-docker-compose/nextcloud
    docker-compose up -d
  ```
  1. 文件管理Nextcloud： <http://localhost:8000>

  2. AriaNg： <http://localhost:8000/aria2/>

  Nextcloud 还需额外的一点手动操作，[链接配置外部存储](https://github.com/wahyd4/aria2-ariang-x-docker-compose/tree/master/nextcloud#nextcloud-配置-external-storage)

## 升级
  进入 filerun, h5ai 或者 nextcloud 目录
  ```bash
  docker-compose stop # 将 docker 镜像暂时关掉
  docker rmi -f < 相关镜像 ID>  # 手动删除对应的 wahyd4/aria2-ariang docker 镜像
  git pull origin master # 获取最近代码
  docker-compose up -d # 运行最新版本的镜像
  ```

## 高级特性
  1. 使用`80`端口。 默认情况下，我们使用8000端口，而不是80端口，主要是防止你可能有其他程序需要使用80端口。但是你可以自己修改对外暴露的端口。

  打开 filerun，h5ai， nextcloud 下面的 `docker-compose.yml`。将 aria2 节点下面的 ports 属性的 `8000` 改为 `80` 即可。

  ```yaml
  aria2:
    image: wahyd4/aria2-ariang:filerun
    links:
      - web:file-manager
    ports:
      - "8000:80" #将此处8000 改为 80端口
      - "6800:6800"
    volumes_from:
      - web
  ```
  2. 对 AriaNg 启用 Basic Auth 登录密码验证，同样地，打开任何一个文件平台下面的 `docker-compose.yml`文件。 启用和修改aria2 服务下面的environment 相关属性：
  ```yaml
    environment:
        - ARIA2_USER=admin #basic auth 用户名
        - ARIA2_PWD=password #basic auth 密码
        - ENABLE_AUTH=true # 是否启用用户名和密码验证, 默认情况下不启用，当该值为 false 时也不启用。
  ```

  3. 启用 HTTPS，为了实现该功能，我们采用 Caddy 来作为我们的 web 服务器和反向代理服务器。当我们绑定域名后，Caddy 自动为站点启用 HTTPS。也仅仅需要修改相应 `docker-compose.yaml`文件下 aria2服务的相关属性即可。（由于 filerun 程序本身的问题，目前暂不支持 HTTPS）
  ```yaml
    environment:
      - DOMAIN=demo.toozhao.com #这里输入你想要绑定的域名， 必须首先在域名管理处添加 A 记录。当我们仅仅通过 ip 访问时则应该改为： :80, 这表示绑定所有可以使用的 ip
      - SSL=true #当值为 true 时，系统会自动启用 HTTPS
      - RPC_SECRET=Hello #这个属性是 配置AriaNg 连接 Aria2 时需要，你可以输入你想要设置的密码。一旦设置了 HTTPS, Aria2 也只能使用 HTTPS。这时就必须使用该设置。
  ```
  由于配置 HTTPS比较麻烦，图文请参见[启用SSL](https://github.com/wahyd4/aria2-ariang-x-docker-compose/blob/master/enable-ssl.md)

## 找到你下载的文件

  这里的 docker-compose 文件，将本地的`/data` 目录作为了 docker volume 来存储下载的各类文件，因此你可以在`/data` 目录找到所有文件。

## 只想运行一个镜像？(如：在群晖中运行)
  ```bash
    docker run -d -p 8000:80  -p 6800:6800 -v ~/data/:/data wahyd4/aria2-ui
  ```
  `8000` 本地则是你暴露出对外访问的 AriaNg 图形界面的端口， `~/data/` 是你所有通过 Aria2 下载的文件目录。
  * Aria2: <http://localhost:8000>
  * FileManger: <http://localhost:8000/files>

  关于该镜像的更多使用介绍，请参考：<https://github.com/wahyd4/aria2-ariang-docker>

## 常见问题

  * 没有权限管理下载的文件？ 请考虑使用 `root` 用户运行 docker 程序。延伸阅读： <https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo>
## 感谢

  * 创建 docker-compose 这个想法灵感源自于阅读了这帖子 <https://www.v2ex.com/t/383801>
  * Aria2 Docker 镜像部分脚本来自 <https://doub.io/wlzy-30/>



