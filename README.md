# Aria2-AriaNg-X docker-compose

<!-- TOC -->

- [Aria2-AriaNg-X docker-compose](#aria2-ariang-x-docker-compose)
  - [为什么会有这个东西](#为什么会有这个东西)
  - [比较 Filerun 和 Nextcloud](#比较-filerun-和-nextcloud)
  - [我的推荐](#我的推荐)
  - [使用](#使用)
  - [Nextcloud 配置 external-storage](#nextcloud-配置-external-storage)
  - [升级](#升级)
  - [高级特性](#高级特性)
  - [找到你下载的文件](#找到你下载的文件)
  - [如果你仅仅想使用 Aria2 + AriaNg](#如果你仅仅想使用-aria2--ariang)
  - [VPS](#vps)
  - [感谢](#感谢)

<!-- /TOC -->

这个项目是提供一个 docker-compose文件，让你可以一步就拥有一个集图形化界面的 Aria2下载（[AriaNg](https://github.com/mayswind/AriaNg)）和在线预览和管理文件的平台（[FileRun](https://www.filerun.com/) 或者 [Nextcloud](https://nextcloud.com/)）。


## 为什么会有这个东西
  * 使用 Docker-compose 让每个 docker 镜像只做一件事，则其本身会更加稳定，不易受其他组件的影响，也更方便管理
  * AriaNg 着实比之前的 Aria2 之前的其他图形化界面程序漂亮了太多。让人很喜欢。
  * 在线查看，预览下载的文件，让我们自己在自己 vps 上就可以拥有某些在线服务商提供的离线下载（迅雷、115）这样的功能。而且所有的控制权都在你手里，不用担心被删除资源

## 比较 Filerun 和 Nextcloud

|比较类别 | Filerun | Nextcloud |
|---- | --- | --- |
|Docker 镜像大小| 约226M | 约104M |
|是否轻量级| 轻量级 | 也比较轻量级 |
|功能| 功能少 | 功能强大 |
|UI| 一般 | 精美 |
|依赖| 必须要Mysql数据库 | 可以直接使用 内嵌SQLlite，也可以使用其他外置数据库 |
|集成难度|全自动，无需人工操作|需要人工操作两步|
|客户端|无|有移动和桌面客户端|
|容器数量|mysql, filerun, aria2|nextcloud, aria2|
|总结|轻量级|功能全面，本身可以作为一个很好的云盘使用|


## 我的推荐

    我更喜欢 Nextcloud。毕竟颜值更高，功能强大还有各种客户端，大家从下面的两种方式中选择一种就好。

## 使用

  *提示* 如果你不是在本地安装，请记得替换 localhost 为你的 ip 或者绑定的域名哦！！

  * 安装 Docker CE (社区版)，不要使用 Ubuntu 等操作系统系统自带的安装包来安装，因为他们的版本都很老了。推荐使用[官方提供](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)的方式安装

  * 安装 Docker Compose <https://docs.docker.com/compose/install/#install-compose>

  ###  使用 **Filerun** 作为在线文件管理器：
  ```bash
    git clone https://github.com/wahyd4/aria2-ariang-x-docker-compose.git
    cd aria2-ariang-x-docker-compose/filerun
    docker-compose up -d
  ```
  一切搞定，尽情享受吧！

  * 文件管理Filerun, 请使用 `superuser / superuser` 进行登录： <http://localhost:8000>

  * AriaNg： <http://localhost:8000/aria2>

  ### 使用 **Nextcloud** 安装
  ```bash
    git clone https://github.com/wahyd4/aria2-ariang-x-docker-compose.git
    cd aria2-ariang-x-docker-compose/nextcloud
    docker-compose up -d
  ```
  * 文件管理Nextcloud： <http://localhost:8000>

  * AriaNg： <http://localhost:8000/aria2>

  Nextcloud 还需额外的一点手动操作
## Nextcloud 配置 external-storage
  * 打开 http://ip:3000 `使用你喜欢的任意密码进行登录`
  * 点击右上角 设置 -> 应用
  * 启用 External storage support 插件, 并输入密码确认

  ![plugin](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/external-storage.png)
  * 点击右上角 设置 -> 管理 -> 外部存储 进行添加外部存储, Aria2 下载的文件会存在/user-files/ 目录下，存储类型选择本地存储，当存储添加成功，且可用时，最左端会显示出绿色。
  ![Add external storage](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/config-storage.png)

  搞定，现在你通过 AriaNg 下载的文件就可以在 Nextcloud 里面查看到了。

  ![Files](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/downloads-folder.png)

## 升级
  进入 filerun 或者 nextcloud 目录
  ```bash
  docker-compose stop # 将 docker 镜像暂时关掉
  git pull origin master # 获取最近代码
  docker-compose up -d # 运行最新版本的镜像
  ```

## 高级特性
  * 使用`80`端口。 默认情况下，我们使用8000端口，而不是80端口，主要是防止你可能有其他程序需要使用80端口。但是你可以自己修改对外暴露的端口。

  打开 filerun 或者 nextcloud 下面的 `docker-compose.yml`。将 aria2 节点下面的 ports 属性的 `8000` 改为 `80` 即可。

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

## 找到你下载的文件

  这里的 docker-compose 文件，将本地的`/data` 目录作为了 docker volume 来存储下载的各类文件，因此你可以在`/data` 目录找到所有文件。

## 如果你仅仅想使用 Aria2 + AriaNg
  ```bash
    docker run --rm  -p 8000:80  -p 6800:6800 -v ~/data/:/user-files wahyd4/aria2-ariang
  ```
  `8000` 本地则是你暴露出对外访问的 AriaNg 图形界面的端口， `~/data/` 是你所有通过 Aria2 下载的文件目录。
## VPS

  我在 Vultr 迈阿密节点建了一个 $2.5 的服务器来测试，速度还挺快的。为什么选迈阿密？ 因为电信节点日本和美国西部都不好用了，测试了一圈最近就迈阿密速度还挺高，虽然延迟比较高。

  欢迎使用我的推荐链接注册使用 Vultr。

  <a href="https://www.vultr.com/?ref=6908774"><img src="https://www.vultr.com/media/banner_2.png" width="468" height="60"></a>

## 感谢

  * 创建 docker-compose 这个想法灵感源自于阅读了这帖子 <https://www.v2ex.com/t/383801>
  * Aria2 Docker 镜像部分脚本来自 <https://doub.io/wlzy-30/>



