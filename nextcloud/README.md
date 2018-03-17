## Nextcloud 配置 external-storage
  * 首先需要配置 docker compose 文件中，`nextcloud` 下的`volumes` 属性，也就是添加mount 目录。将你需要映射的外部存储目录添加到这里，记得修改完成后，重启本 docker-compose 项目。
  ```yaml
  volumes:
      - /data/nextcloud:/data
      - /data:/user-files
      - /abc:/abc
  ```
  * 打开 <http://ip:8000> `使用你喜欢的任意密码进行登录`
  * 点击右上角 设置 -> 应用
  * 启用 External storage support 插件, 并输入密码确认

  ![plugin](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/external-storage.png)
  * 点击右上角 设置 -> 管理 -> 外部存储 进行添加外部存储, Aria2 下载的文件会存在/user-files/ 目录下，存储类型选择本地存储，当存储添加成功，且可用时，最左端会显示出绿色。
  ![Add external storage](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/config-storage.png)

  搞定，现在你通过 AriaNg 下载的文件就可以在 Nextcloud 里面查看到了。

  ![Files](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/downloads-folder.png)

## 注意：

很多童鞋在 issue 里面提到了说，不能上传文件的问题。的确，我之前主要是在 Mac 下进行开发和调试没有这个问题，刚刚在 Centos 下经过测试却有这个问题，Nextcloud Github 上面也有一个[相关问题](https://github.com/nextcloud/docker/issues/229)，目前暂时没有解决。

通过查看 Nextcloud 容器内部的文件（docke exec -it 该容器id sh）发现：
```bash
drwxr-xr-x    2 root      root          4096 Mar 17 21:47 abc
drwxr-xr-x    2 991      991           4096 Mar 17 21:27 apps2
drwxr-xr-x    1 root     root          4096 Feb 10 13:31 bin
drwxr-xr-x    2 991      991           4096 Mar 17 21:27 config
drwxrwx---    6 991      991           4096 Mar 17 21:50 data
```
被 Nextcloud 管理的目录，用户叫`991`，我们是用权限访问和上传该目录的，而我们新添加的目录`abc` 则是属于`root`用户。可以尝试下面的命令行
```
sudo chown -R 991 /abc  #这里是你需要修改的目录
```
即是把该目录所有者修改成 Nextcloud 的用户，无须重启，再次尝试在浏览器里面上传文件，即可成功了。

如果遇到页面右上角显示`You don’t have permission to upload or create files here` 请忽略即可。
