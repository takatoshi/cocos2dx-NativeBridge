cocos2dx-NativeBridge
=====================

The static library used in cocos2d-x that integrates third party SDK.

# Require
* cocos2d-x ver3.3(or greater
* android-10(or greater

# How to setup

## common
* create plugins directory under your project and clone this repository.

```sh
cd /path/to/your-project
mkdir plugins && cd plugins
git clone git@github.com:takatoshi/cocos2dx-NativeBridge.git
```

## iOS
1. Add `cocos2dx-NativeBridge/ios` to your project.
2. Add `$(SRCROOT)/../plugins` to the Header Search Paths in your project.
3. Add `-Objc`to the Other Linker Flags in your project.
4. Add following frameworks to your project.
   * AdSupport
   * AudioToolbox
   * AVFoundation
   * CoreGraphics
   * CoreTelephony
   * EventKit
   * EventKitUI
   * MessageUI
   * StoreKit
   * SystemConfiguration
   * iAd
   * ImageIO
   * GameKit
   * MediaPlayer
   * GameController
   * CoreData
   * libsqlite3.0.dylib
   * libz.dylib

## Android
* Update project.properties file.

```sh
cd /path/to/your-project/proj.android
android update project -p . -t [android API level]
android update project -p . -l ../plugins/cocos2dx-NativeBridge/android/java
```

* Update Android.mk file.

```sh
open /path/to/your-project/proj.android/jni/Android.mk
```

```diff
+LOCAL_STATIC_LIBRARIES += nativebridge_plugin_static
+$(call import-module,../plugins/cocos2dx-NativeBridge/android)
```
