LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := nativebridge_plugin_static

LOCAL_MODULE_FILENAME := libnativebridgeplugin

LOCAL_SRC_FILES := \
NativeBridgeAndroid.cpp \
jni/NativeBridgeJNI.cpp

LOCAL_WHOLE_STATIC_LIBRARIES := cocos2dx_static

LOCAL_EXPORT_C_INCLUDES := $(LOCAL_PATH)
LOCAL_EXPORT_C_INCLUDES += $(LOCAL_PATH)/..

LOCAL_C_INCLUDES :=  \
                    $(LOCAL_PATH)/../ \
                    $(LOCAL_PATH)/ \
                    $(LOCAL_PATH)/jni

include $(BUILD_STATIC_LIBRARY)
$(call import-module,.)
