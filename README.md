# app-hybrid-demo
Demo of app-hybrid

# Project Target

Combine with app-hybrid-core, we need to:

1. SHELL SCRIPT: auto checkout app-hybrid-core to {$proj}/../../
2. API:  _demo_get_phone_info() as a demo api call for webview to get the phone info
3. SHELL SCRIPT: build/pack/sign the target apk/ipa to build\ base on {$proj}\config.json

# 【CHS】说明

我们不是要取代 cordova/crosswalk 这种体量的项目！ 我们要的是简单配置、简单代码就能跑起来的 webview/hybrid app！


# Folder and Files

* $proj/../../app-hybrid-core/
dependency to hybrid core

* lib-ios\
* lib-ios\szu-bdi-hybrid-demo_get_phone_info\  [0%]
demo api _demo_get_phone_info for ios

* lib-android\
* lib-android\szu.bdi.hybrid.demo_get_phone_info\  [0%]
demo api _demo_get_phone_info for android

* $proj = ./proj-{$os}-demo/ [DONE]

* $proj/assets/ [50%]

* $proj/config/ [DONE]

* $proj/config/config.json [DONE]
the config for demo

* $proj/build-ipa-on-mac.sh
the SHELL SCRIPT for build ipa on mac machine

* $proj/build-apk-on-linux.sh
the SHELL SCRIPT for build apk on linux machine

* $proj/build-apk-on-mac.sh [DONE]
the SHELL SCRIPT for build apk on mac machine

