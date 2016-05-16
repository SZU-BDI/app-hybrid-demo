# app-hybrid-demo
Demo Site of app-hybrid

# Project Target

Combine with app-hybrid-core, we need to complete these tasks:

1. SHELL SCRIPT: auto checkout/copy/sync app-hybrid-core to $my_project\build\
2. SHELL SCRIPT: build and pack target apk/ipa to build\ base on $my_project\config.json
3. SHELL SCRIPT: sign and deploy binary to app store. [user/pass/cert would be prompted]

# Folder

* ..\app-hybrid-demo\         //the folder for the script git pull into
* build\                      //things for build but not in repository
* lib-ios\
* lib-ios\szu-bdi-hybrid-demo_msgbox\      //demo api _demo_msgbox for ios
* lib-android\
* lib-android\szu.bdi.hybrid.demo_msgbox\  //demo api _demo_msgbox for android
* assets\                     //assets file such as loader.htm and related   
* config.json                 //the config for demo
* build-ipa-on-mac.sh         //the SHELL SCRIPT for build ipa on mac machine
* build-apk-on-linux.sh       //the SHELL SCRIPT for build ipa on linux machine   
* build-apk-on-mac.sh         //the SHELL SCRIPT for build ipa on linux machine   
