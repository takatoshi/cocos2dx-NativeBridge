#include "NativeBridgeJNI.h"
#include "platform/android/jni/JniHelper.h"
#include <string.h>
#include <jni.h>

#define kShareHelper "com/tactosh/NativeBridgeHelper"

using namespace cocos2d;

extern "C" {
    void openUrlJNI(const char* url) {
        JniMethodInfo t;
        if (JniHelper::getStaticMethodInfo(t, kShareHelper, "openUrl", "(Ljava/lang/String;)V")) {
            jstring jUrl = t.env->NewStringUTF(url);
            t.env->CallStaticVoidMethod(t.classID, t.methodID, jUrl);

            t.env->DeleteLocalRef(jUrl);
            t.env->DeleteLocalRef(t.classID);
        }
    }
}
