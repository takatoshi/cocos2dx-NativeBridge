cocos2dx-NativeBridge
=====================

The static library used in cocos2d-x that integrates third party SDK.

# Require
* cocos2d-x ver3.3(or greater
* android-10(or greater

# How to setup

## common
* create libs directory under your project and clone this repository.

```sh
cd /path/to/your-project
mkdir libs && cd libs
git clone git@github.com:takatoshi/cocos2dx-NativeBridge.git
```

## iOS
1. Add `cocos2dx-NativeBridge/ios` to your project.
2. Add `$(SRCROOT)/../libs` to the Header Search Paths in your project

## Android
* Update project.properties file.

```sh
cd /path/to/your-project/libs/cocos2dx-NativeBridge/android/java
android update project -p . -t [android API level]
android update project -p . -l ../../../../cocos2d/cocos/platform/android/java
cd /path/to/your-project/proj.android
android update project -p . -t [android API level]
android update project -p . -l ../libs/cocos2dx-WebView/android/java
```

* Update Android.mk file.

```sh
open /path/to/your-project/proj.android/jni/Android.mk
```

```diff
+LOCAL_STATIC_LIBRARIES += nativebridge_plugin_static
+$(call import-module,../libs/cocos2dx-NativeBridge/android)
```
