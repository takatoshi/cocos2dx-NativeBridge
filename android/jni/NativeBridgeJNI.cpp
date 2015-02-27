#include "NativeBridgeJNI.h"
#include "platform/android/jni/JniHelper.h"
#include <string.h>
#include <jni.h>

#define kShareHelper "com/tactsh/NativeBridgeHelper"

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

    void loginGameCenterJNI() {
        JniMethodInfo t;
        if (JniHelper::getStaticMethodInfo(t, kShareHelper, "loginGameCenter", "()V")) {
            t.env->CallStaticVoidMethod(t.classID, t.methodID);

            t.env->DeleteLocalRef(t.classID);
        }
    }

    void openRankingJNI() {
        JniMethodInfo t;
        if (JniHelper::getStaticMethodInfo(t, kShareHelper, "openRanking", "()V")) {
            t.env->CallStaticVoidMethod(t.classID, t.methodID);

            t.env->DeleteLocalRef(t.classID);
        }
    }

    void postHighScoreJNI(const char* key, double score) {
    }

    void showAdJNI() {
        JniMethodInfo t;
        if (JniHelper::getStaticMethodInfo(t, kShareHelper, "showAd", "()V")) {
            t.env->CallStaticVoidMethod(t.classID, t.methodID);

            t.env->DeleteLocalRef(t.classID);
        }
    }

    void hideAdJNI() {
        JniMethodInfo t;
        if (JniHelper::getStaticMethodInfo(t, kShareHelper, "hideAd", "()V")) {
            t.env->CallStaticVoidMethod(t.classID, t.methodID);

            t.env->DeleteLocalRef(t.classID);
        }
    }

    void loadInterstitialAdJNI() {
        JniMethodInfo t;
        if (JniHelper::getStaticMethodInfo(t, kShareHelper, "loadInterstitialAd", "()V")) {
            t.env->CallStaticVoidMethod(t.classID, t.methodID);

            t.env->DeleteLocalRef(t.classID);
        }
    }

    void showInterstitialAdJNI() {
        JniMethodInfo t;
        if (JniHelper::getStaticMethodInfo(t, kShareHelper, "showInterstitialAd", "()V")) {
            t.env->CallStaticVoidMethod(t.classID, t.methodID);

            t.env->DeleteLocalRef(t.classID);
        }
    }

    void gaSetupJNI() {
        JniMethodInfo t;
        if (JniHelper::getStaticMethodInfo(t, kShareHelper, "gaSetup", "()V")) {
            t.env->CallStaticVoidMethod(t.classID, t.methodID);

            t.env->DeleteLocalRef(t.classID);
        }
    }

    void sendScreenJNI(const char* screenName) {
        JniMethodInfo t;
        if (JniHelper::getStaticMethodInfo(t, kShareHelper, "sendScreen", "(Ljava/lang/String;)V")) {
            jstring jValue = t.env->NewStringUTF(screenName);
            t.env->CallStaticVoidMethod(t.classID, t.methodID, jValue);

            t.env->DeleteLocalRef(jValue);
            t.env->DeleteLocalRef(t.classID);
        }
    }

    void postWithImageJNI(const char* message, const char* filePath) {
        JniMethodInfo t;
        if (JniHelper::getStaticMethodInfo(t, kShareHelper, "postWithImage", "(Ljava/lang/String;Ljava/lang/String;)V")) {
            jstring jmessage = t.env->NewStringUTF(message);
            jstring jfilepath = t.env->NewStringUTF(filePath);
            t.env->CallStaticVoidMethod(t.classID, t.methodID, jmessage, jfilepath);

            t.env->DeleteLocalRef(jmessage);
            t.env->DeleteLocalRef(jfilepath);
            t.env->DeleteLocalRef(t.classID);
        }
    }
}
