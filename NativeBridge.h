#ifndef __NativeBridge_H_
#define __NativeBridge_H_

class NativeBridge {
public:
    static void openUrl(const char* url);

    static void loginGameCenter();
    static void openRanking();
    static void postHighScore(const char* key, double score);
    static void openAchievement();
    static void postAchievement(const char* key, int percentComplete);

    static void showAd();
    static void hideAd();
    static void loadInterstitialAd();
    static void showInterstitialAd();

    static void gaSetup();
    static void sendScreen(const char* screenName);
    
    static void postWithImage(const char* message, const char* filePath);
};

#endif //__NativeBridge_H_
