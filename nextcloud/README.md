## Nextcloud 配置 external-storage
  * 首先需要配置 docker compose 文件中，`nextcloud` 下的`volumes` 属性，也就是添加mount 目录。将你需要映射的外部存储目录添加到这里，记得修改完成后，重启本 docker-compose 项目。
  ```yaml
  volumes:
      - /data/nextcloud:/var/www/html
      - /data:/data
      - /abc:/abc
  ```
  * 在宿主机上执行命令 `sudo chown -R www-data <abc>` #<>这里是你需要修改的目录, 让Nextcloud 有权限读写、管理文件
  * 打开 <http://ip> `使用你喜欢的任意密码进行登录`
  * 点击右上角 设置 -> 应用
  * 启用 External storage support 插件, 并输入密码确认

  ![plugin](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/external-storage.png)
  * 点击右上角 设置 -> 管理 -> 外部存储 进行添加外部存储, Aria2 下载的文件会存在/data 目录下，存储类型选择本地存储，当存储添加成功，且可用时，最左端会显示出绿色。
  ![Add external storage](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/config-storage.png)

  搞定，现在你通过 AriaNg 下载的文件就可以在 Nextcloud 里面查看到了。

  ![Files](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/downloads-folder.png)

## 注意：
***非常重要***

很多童鞋在 issue 里面提到了说，不能上传文件的问题。页面提示: `You don’t have permission to upload or create files here`

被 Nextcloud 管理的目录，用户叫`www-data`，Nextcloud 内所有文件的所有权都属于`www-data`，而我们新添加的目录`abc` 则是属于`root`用户。我们需要赋予`www-data` 用户读写我们需要绑定的目录的权限。

```
sudo chown -R www-data </abc>  #<>这里是你需要修改的目录
```
如果已经添加了`External Storage`，请从`External Storage`移除该条目录，然后再重新添加该目录，就没问题啦！如果依然还有问题，请回来报告Issue。
