# Aria2-AriaNg-X docker-compose

这个项目是提供一个 docker-compose文件，让你可以一步就拥有一个集图形化界面的 Aria2下载（[AriaNg](https://github.com/mayswind/AriaNg)）和在线预览和管理文件的平台（[FileRun](https://www.filerun.com/) 或者 [Nextcloud](https://nextcloud.com/)）。


## 为什么会有这个东西
  * 使用 Docker-compose 让每个 docker 镜像只做一件事，则其本身会更加稳定，不易受其他组件的影响，也更方便管理
  * AriaNg 着实比之前的 Aria2 之前的其他图形化界面漂亮了太多。让人很喜欢。
  * 在线查看，预览下载的文件，让我们自己在自己 vps 上就可以拥有某些在线服务商提供的离线下载（迅雷、115）这样的功能。而且所有的控制权都在你手里，不用担心被删除资源

## 比较 Filerun 和 Nextcloud

|比较类别 | Filerun | Nextcloud |
|---- | --- | --- |
|是否轻量级| 轻量级 | 也比较轻量级 |
|功能| 功能少 | 功能强大 |
|UI| 一般 | 精美 |
|依赖| 必须要Mysql数据库 | 可以直接使用 内嵌SQLlite，也可以使用其他外置数据库 |
|集成难度|全自动，无需人工操作|需要人工操作两步|
|客户端|无|有移动和桌面客户端|
|容器数量|mysql, filerun, aria2|nextcloud, aria2|
|总结|轻量级|功能全面，本身可以作为一个很好的云盘使用|


## 我的选择

    我更喜欢 Nextcloud。毕竟颜值更高，功能强大还有各种客户端，大家从下面的两种方式中选择一种就好。

## 使用
  * 安装 Docker CE (社区版)，不要使用 Ubuntu 等操作系统系统自带的安装包来安装，因为他们的版本都很老了。推荐使用[官方提供](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)的方式安装
  * 使用 Filerun 作为在线文件管理器：
  ```bash
    git clone git@github.com:wahyd4/aria2-ariang-x-docker-compose.git
    cd aria2-ariang-x-docker-compose/filerun
    docker-compose up -d
  ```
  一切搞定，尽情享受吧！
  文件管理Filerun： <http://localhost:3000>

  AriaNg： <http://localhost:8000>

  * 使用 nextcloud 安装
  ```bash
    git clone git@github.com:wahyd4/aria2-ariang-x-docker-compose.git
    cd aria2-ariang-x-docker-compose/nextcloud
    docker-compose up -d
  ```
  文件管理Nextcloud： <http://localhost:3000>

  AriaNg： <http://localhost:8000>

  Nextcloud 还需额外的一点手动操作

## Nextcloud 配置 external-storage
  * 打开 http://ip:3000 使用你喜欢的密码进行登录，为了方便数据库保持默认选择
  * 点击右上角 设置 -> 应用
  * 启用 External storage support 插件, 并输入密码确认

  ![plugin](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/external-storage.png)
  * 点击右上角 设置 -> 管理 -> 外部存储 进行添加外部存储, Aria2 下载的文件会存在/user-files/ 目录下，存储类型选择本地存储，当存储添加成功，且可用时，最左端会显示出绿色。
  ![Add external storage](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/config-storage.png)

  搞定，现在你通过 AriaNg 下载的文件就可以在 Nextcloud 里面查看到了。
  ![Files](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/downloads-folder.png)

## 感谢

  * 创建 docker-compose 这个想法灵感源自于阅读 <https://www.v2ex.com/t/383801#reply68>
  * 部分脚本来自 <https://doub.io/wlzy-30/>



