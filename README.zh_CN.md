
# deepin-dummyapps

本仓库包含部分应用的“占位包“的源码包，这些占位包旨在减小安装镜像尺寸，它们将被预装在全新安装的系统上，提供应用图标引导用户前往应用商店下载应用。

此源码包设计上可以构建出多个“占位包“。

## 构建

本仓库的唯一作用是构建 deb 包，所以请确保安装了 Debian 的打包设施程序。需安装 `gettext` 和 `gettext-base` 。

```sh
debuild
```

## 添加新的占位应用

**当前，只存在一个占位应用（WPS Office），故尚未使用 Debian 的分包机制。当未来添加新的应用时，请将`./dummyapp-wpsoffice.install` 移动至 `./debian` 目录中，并为对应的占位包添加 `.install` 文件和 `control` 项。（`.install` 文件现在没有放进 `./debian` 的原因是，只构建出单个二进制包时，这样做会使打包过程异常。）**

**请在启用分包机制后删除这些粗体的 Readme。**

需要编辑的文件汇总：

- 在 `./debian/control` 中添加一个二进制包项
- 在 `Makefile` 中添加 shell 脚本的翻译文件生成命令，即 `generate_po` 和 `generate_mo` 目标
- 在 `Makefile` 中把对应的文件安装到 `$DESTDIR`
- 在 `./debian` 中添加对应的 `./<新占位应用>.install` 描述分包中包含的文件

## 翻译

目前占位应用被启用时，会发送一条通知并在应用商店中拉起对应应用的页面。通知文本应当被翻译。

由于通知是用 shell 脚本发送的，国际化使用了 `gettext` 进行。

### 更新翻译文件

```sh
make generate_po
```

此目标会在 `./i18n` 生成 `.pot` 并更新对应的 `.po` 文件。

构建二进制包时 `generate_mo` 目标将被执行。

`.pot` 和 `.mo` 文件会被 `clean` 目标清除。

## 帮助

- [官方论坛](https://bbs.deepin.org/) 
- [开发者中心](https://github.com/linuxdeepin/developer-center) 
- [Wiki](https://wiki.deepin.org/)

## 贡献指南

我们鼓励您报告问题并做出更改

- [开发者代码贡献指南](https://github.com/linuxdeepin/developer-center/wiki/Contribution-Guidelines-for-Developers) 

## 开源许可证


deepin-dummyapps 在 [ GPL-3.0-or-later ](LICENSE) 下发布。
