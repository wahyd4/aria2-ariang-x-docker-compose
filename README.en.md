# Aria2-AriaNg-X docker-compose

<a href="https://badges.toozhao.com/stats/01EGZCMEMXYQQMRN7H8ZWPJXCY" alt="Generate your badge to count for any page views at https://badges.toozhao.com"><img src="https://badges.toozhao.com/badges/01EGZCMEMXYQQMRN7H8ZWPJXCY/green.svg"/></a>



[中文](https://github.com/wahyd4/aria2-ariang-x-docker-compose/blob/master/README.md) | English

<img src="https://raw.githubusercontent.com/wahyd4/work-in-australia/766592ac6318027d7b3c334d8c50ca80818eeff8/wepay.jpg" alt="buy me a drink" width="120"/>

> Notice: The English version documentation is not up to date, if you have any issues, please create an issue. Translation pull request is welcome.

<!-- TOC -->

- [Aria2-AriaNg-X docker-compose](#aria2-ariang-x-docker-compose)
  - [Screenshots](#screenshots)
  - [Why this repository](#why-this-repository)
  - [Comparing among Filerun, h5ai and Nextcloud](#comparing-among-filerun-h5ai-and-nextcloud)
  - [How to run](#how-to-run)
  - [Upgrade](#upgrade)
  - [Advanced features](#advanced-features)
  - [Get your downloaded files](#get-your-downloaded-files)
  - [FAQ](#faq)
  - [Just want to a standalone image?(e.g. Running in Synology NAS)](#just-want-to-a-standalone-imageeg-running-in-synology-nas)

<!-- /TOC -->

This repository contains several docker-compose files to help you running a Aria2 platform with UI ([AriaNg](https://github.com/mayswind/AriaNg)) and a online file management application. All the file management application are:
  * [FileRun](https://www.filerun.com/)
  * [Nextcloud](https://nextcloud.com/)
  * [h5ai](https://larsjung.de/h5ai/)

## Screenshots
Name|Screenshot
:----: | :---:
 AriaNg|![AriaNg](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/ariang.jpg)
 Filerun|![filerun](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/filerun.jpg)
 h5ai|![h5ai](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/h5ai.png)
nextcloud|![nextcloud](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud.png)

## Why this repository
  * By using docker-compose, each container only do one thing and do it well.
  * AriaNg is much better beautiful UI interface then any other similar application.
  * You can preview, play, download your images and videos.


## Comparing among Filerun, h5ai and Nextcloud

|Category | Filerun | Nextcloud | h5ai|
|---- | --- | --- | --- |
|Docker image size| 226M | 104M | 21M |
|if lightweight| yes | kind of | most lightweight |
|functionalities| middle level | powerful | few |
|UI| simple and beautiful | simple and elegant | simple |
|dependencies| Mysql | You can use SQLite | no need db |
|easy to use ?|no manual step|needs manual steps| no manual steps |
|client |no |Mobile and desktop| no|
|security|username and password|multiple kinds of users authentication| no|
|containers count|mysql, filerun, aria2|nextcloud, aria2| h5ai, aria2 |
|summary|lightweight and easy to use|powerful and beautiful| least functions|


## How to run
  *Notice* If you aren't do it in your local machine, please update the IP address with your real IP address!

  1. Install Docker CE first, [Official](https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/)

  2. Install Docker Compose <https://docs.docker.com/compose/install/#install-compose>
  #### Using **h5ai** as the file managment application.
  ```bash
    git clone https://github.com/wahyd4/aria2-ariang-x-docker-compose.git
    cd aria2-ariang-x-docker-compose/h5ai
    docker-compose up -d
  ```
  done!

  1. h5ai： <http://localhost:8000>

  2. AriaNg： <http://localhost:8000/aria2/>
  ####  Using **Filerun** as the file managment application.
  ```bash
    git clone https://github.com/wahyd4/aria2-ariang-x-docker-compose.git
    cd aria2-ariang-x-docker-compose/filerun
    docker-compose up -d
  ```
  Bingo!

  1. Please use `superuser / superuser` as the username and password to login： <http://localhost:8000>

  2. AriaNg： <http://localhost:8000/aria2/>

  #### Using **Nextcloud** as the file managment application
  ```bash
    git clone https://github.com/wahyd4/aria2-ariang-x-docker-compose.git
    cd aria2-ariang-x-docker-compose/nextcloud
    docker-compose up -d
  ```
  1. Nextcloud： <http://localhost:8000>

  2. AriaNg： <http://localhost:8000/aria2/>

  Nextcloud needs some more manual steps，[Configure external storage](https://github.com/wahyd4/aria2-ariang-x-docker-compose/tree/master/nextcloud#nextcloud-配置-external-storage)

## Upgrade
  go to the filerun/ h5ai/ nextcloud folder
  ```bash
  docker-compose stop # stop the containers
  git pull origin master # pull latest code
  docker-compose pull # pull the latest docker images
  docker-compose up -d # running the latest docker images
  ```

## Advanced features
  * Using `80` port. By default we used `8000`  port, not the `80`， but you can use any port you want in one step.

  Modify the docker-compose.yml you want, and update the port in field of `ports:`

  ```yaml
  aria2:
    image: wahyd4/aria2-ui:filerun
    links:
      - web:file-manager
    ports:
      - "8000:80" #change it to 80
      - "6800:6800"
    volumes_from:
      - web
  ```

## Get your downloaded files
  In docker-compose, we used `/data` as the docker volumn folder to storage all kinds of files. So you can find your files in `/data`

## FAQ

  * Have no rights to manage the files you downloaded? Considering using `root` user to run docker program. Please refer: <https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo>
  * Doesn't support ARM CPUs? Currently there is no plan shortly to release a docker-compose version to support ARM, but recommend you try [`wahyd4/aria2-ui:arm64`](https://github.com/wahyd4/aria2-ariang-docker)
## Just want to a standalone image?(e.g. Running in Synology NAS)
  ```bash
    docker run --rm  -p 80:80  -p 443:443 -v ~/data/:/data wahyd4/aria2-ui
  ```
  `8000` is the exposed port of AriaNg， `~/data/` is the data folder on your host machine(outside docker).

  * FileBrowser: <http://localhost:8000>
  * AriaNG: <http://localhost:8000/ui>

  More examples please refer: <https://github.com/wahyd4/aria2-ariang-docker>
