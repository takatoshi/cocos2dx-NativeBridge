#include "NativeBridge.h"
#include "jni/NativeBridgeJNI.h"

void NativeBridge::openUrl(const char* url) {
    openUrlJNI(url);
}

void NativeBridge::loginGameCenter() {
}

void NativeBridge::openRanking() {
}

void NativeBridge::postHighScore(const char* key, double score) {
}

void NativeBridge::showAd() {
    showAdJNI();
}

void NativeBridge::hideAd() {
    hideAdJNI();
}

void NativeBridge::loadInterstitialAd() {
    loadInterstitialAdJNI();
}

void NativeBridge::showInterstitialAd() {
    showInterstitialAdJNI();
}

void NativeBridge::gaSetup() {
#if !defined(COCOS2D_DEBUG) || COCOS2D_DEBUG == 0
    gaSetupJNI();
#endif
}

void NativeBridge::sendScreen(const char* screenName) {
#if !defined(COCOS2D_DEBUG) || COCOS2D_DEBUG == 0
    sendScreenJNI(screenName);
#endif
}
