#ifndef __NativeBridgeJNI_H
#define __NativeBridgeJNI_H

extern "C"
{
    void openUrlJNI(const char* url);
    void loginGameCenterJNI();
    void openRankingJNI();
    void postHighScoreJNI(const char* key, double score);
    void showAdJNI();
    void hideAdJNI();
    void loadInterstitialAdJNI();
    void showInterstitialAdJNI();
    void gaSetupJNI();
    void sendScreenJNI(const char* screenName);
}

#endif //__NativeBridgeJNI_H
