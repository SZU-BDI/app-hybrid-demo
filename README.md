# app-hybrid-demo
Demo Site of app-hybrid

# Project Target

Combine with app-hybrid-core, we need to complete these tasks:

1. SHELL SCRIPT: auto checkout/copy/sync app-hybrid-core to $my_project\build\
2. API:  _demo_msgbox() as a demo api call for webview to invoke a native msgbox
3. SHELL SCRIPT: build and pack target apk/ipa to build\ base on $my_project\config.json
4. SHELL SCRIPT: sign and deploy binary to app store. [user/pass/cert would be prompted]

# Folder and Files

* $proj/../../app-hybrid-core         
the dependence of hybrid core

* lib-ios\
* lib-ios\szu-bdi-hybrid-demo_msgbox\     
demo api _demo_msgbox for ios

* lib-android\
* lib-android\szu.bdi.hybrid.demo_msgbox\  
demo api _demo_msgbox for android

* $proj = ./proj-{$os}-demo/

* $proj/assets/

* $proj/config.json                 
the config for demo

* $proj/build-ipa-on-mac.sh         
the SHELL SCRIPT for build ipa on mac machine

* $proj/build-apk-on-linux.sh       
the SHELL SCRIPT for build apk on linux machine   

* $proj/build-apk-on-mac.sh         
the SHELL SCRIPT for build apk on mac machine   

