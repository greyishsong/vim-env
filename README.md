# README

---

这里包含了一些脚本和配置文件，可以在国内的网络环境下比较稳定地完成`vim`的安装和相关插件的配置。完成配置后的`vim`具有语法高亮、自动补全、目录树、关键词跳转等功能，可以比较友好地进行开发。

使用时需要以`sudo`权限运行`vim-env.sh`脚本：

```shell
$ chmod a+x vim-env.sh
$ sudo ./vim-env.sh
```

对于使用 Devstack 默认部署 OpenStack 的情况，用户`stack`的`$HOME`是`/opt/stack`，但是它却没有这个目录的所有权，这会导致 coc.nvim 运行异常，需要在 root 权限下进行更改：

```shell
# chown -R stack /opt/stack
```

全过程中，只需要在安装 Node.js 时确认一次。如果安装正常，在自动打开 vim 界面安装插件完成后会自动退出，无须操作。

如果报出的所有消息都是`[info]`，那么安装基本上是正常的，如果报了`[error]`一般是网络环境问题，可以自行代理解决或者多试几次。