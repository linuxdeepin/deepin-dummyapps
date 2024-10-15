#!/bin/bash

. gettext.sh

TEXTDOMAIN="dummyapp-wpsoffice"
export TEXTDOMAIN
TEXTDOMAINDIR=/usr/share/locale
export TEXTDOMAINDIR

msg_wps_not_installed=$(eval_gettext "WPS is not installed yet, please install it in the app store."; echo)

notify-send -i deepin-app-store -t 5000 "$msg_wps_not_installed"
dbus-send --session --print-reply=literal --dest=com.home.appstore.client \
    /com/home/appstore/client com.home.appstore.client.openBusinessUri string:'app_detail_info/cn.wps.wps-office'
