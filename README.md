
# deepin-dummyapps

This repository contains the source for some placeholder packages, which will guide the users to install the actual packages in the app store. These packages are supposed to be preinstalled on fresh installs, thus reducing installation media size.

This source package is designed to build multiple dummy packages.

## Building

This repository is solely used to build packages therefore you should install Debian packaging programs. `gettext` and `gettext-base` are required.

```sh
debuild
```

## Adding a new dummy application

**Currently, only one dummy app (WPS Office) is built by this package and Debian's split package mechanism is not yet employed. When adding new application in the future, please move `./dummyapp-wpsoffice.install` to `./debian` directory, and add the corresponding binary package `.install` file and `control` entry for the new dummy apps. (The `.install` file is not put to `./debian` for now since it breaks packaging when only one binary package is being built.)**

**Please delete the bold text after split package is put to use.**

Several files needs to be edited:

- Add a binary package in `./debian/control`
- Add the shell script translations in `Makefile`, specifically `generate_po` and `generate_mo` targets
- Install the corresponding files to `$DESTDIR` in `Makefile`
- Add `./<new-dummy-app>.install` file to `./debian`, which describes what files exists in the split package

## Translation

Currently, dummy apps will send a notification and navigate to corresponding app page in the app store. The notification text is supposed to be translated.

Since notification is currently sent from a shell script, gettext is used to do the i18n work.

### Updating translation files

```sh
make generate_po
```

This target will generate `.pot` files in `./i18n` and update corresponding `.po` files.

`generate_mo` target will be run when the package is being built.

`.mo` files will be removed by `clean` target.

### Transifex Integration

The Transifex filter configured for this repository will make Transifex look for all `./i18n/*.pot` files, treat them as source translation files, strip the file names of their extensions, and generate translation files for other languages under directories with such names in `./i18n/`. Therefore when you write your Makefile, be sure to keep the names same.

Example when adding a new app:

```
i18n/
|
+-- your-dummy-app/
|   |
|   +-- en_US.po
|   +-- zh_CN.po
+-- your-dummy-app.pot
```

## Getting help

 - [Official Forum](https://bbs.deepin.org/)
 - [Developer Center](https://github.com/linuxdeepin/developer-center)
 - [Wiki](https://wiki.deepin.org/)

## Getting involved

We encourage you to report issues and contribute changes

 - [Contribution guide for developers](https://github.com/linuxdeepin/developer-center/wiki/Contribution-Guidelines-for-Developers-en) 

## License

deepin-dummyapps is licensed under [ GPL-3.0-or-later ](LICENSE).
