## 如何启用全站 HTTPS
<!-- TOC -->

- [如何启用全站 HTTPS](#如何启用全站-https)
  - [按照 `README.md` 的要求修改`docker-compose.yaml` 文件](#按照-readmemd-的要求修改docker-composeyaml-文件)
  - [添加域名管理处添加 `A` 记录](#添加域名管理处添加-a-记录)
  - [配置 AriaNg](#配置-ariang)
  - [使用你自己的 SSL 证书来运行 Aria2](#使用你自己的-ssl-证书来运行-aria2)

<!-- /TOC -->

### 按照 `README.md` 的要求修改`docker-compose.yaml` 文件

  参见 README

### 添加域名管理处添加 `A` 记录

 登录到你的域名 DNS 解析托管网站，在你需要绑定的域名下添加一条 `A` 记录，`IP` 指向 运行程序的网站

 ![dns](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/ssl/dns.png)

### 配置 AriaNg
  运行docker-compose， 通过域名访问。我们可以发现站点已经可以通过 HTTPS 进行访问了。但默认情况下 AriaNg 是通过 http 协议和 aria2 进行通信的。因此我们需要修改配置。
  * Aria2 RPC Secret Token 则是docker-compose.yaml 文件中的`RPC_SECRET`值
  * Aria2 RPC Protocol 修改成 HTTPS
  * Aria2 RPC Address 修改成你的域名

  ![dns](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/ssl/ariang.png)

  镜像中我们内置了aria2需要的 `certificate` 和 `key`，但由于是自签名的，默认情况下浏览器是不信任的状态。因为需要用户手动处理。

  访问 <https://你的域名:6800/jsonrpc>， 在 safari 中，在弹出的提示证书窗口中点击 `continue` 即可。 而在 chrome 中，需要点击继续请求的按钮。

  ![proceed request](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/ssl/proceed.png)

### 使用你自己的 SSL 证书来运行 Aria2
  在相应的 docker-compose.yaml中， h5ai 或者 nextcloud 服务下的`volumes` 属性下挂在新的 volume 目录：
  ```yaml
  volumes:
    - /some_folder:/root/conf/key #存放你自己的 certificate 和 key 的目录, 将 some_folder 修改为你自己的目录。
  ```
  `certificate` 和 `key` 文件的名字必须是 `aria2.crt` 和 `aria2.key`

  * 如何生成自己的 certificate 和 key： <https://github.com/ziahamza/webui-aria2/issues/108#issuecomment-176977431> 。当然最好还是从可信的证书提供商处购买证书。
  * certificate和 key 文件的格式，请查考 Aria2 官网文档： <https://aria2.github.io/manual/en/html/aria2c.html#client-certificate-authorization-for-ssl-tls>
