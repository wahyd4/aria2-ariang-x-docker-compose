## Nextcloud 配置 external-storage
  * 打开 http://ip:3000 `使用你喜欢的任意密码进行登录`
  * 点击右上角 设置 -> 应用
  * 启用 External storage support 插件, 并输入密码确认

  ![plugin](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/external-storage.png)
  * 点击右上角 设置 -> 管理 -> 外部存储 进行添加外部存储, Aria2 下载的文件会存在/user-files/ 目录下，存储类型选择本地存储，当存储添加成功，且可用时，最左端会显示出绿色。
  ![Add external storage](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/config-storage.png)

  搞定，现在你通过 AriaNg 下载的文件就可以在 Nextcloud 里面查看到了。

  ![Files](https://raw.githubusercontent.com/wahyd4/aria2-ariang-x-docker-compose/master/images/nextcloud/downloads-folder.png)
