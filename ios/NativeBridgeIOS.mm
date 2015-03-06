#include "NativeBridge.h"
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "GADBannerView.h"
#import "GADInterstitial.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"

static GADBannerView *bannerView;
static GADInterstitial *interstitial;

#define ADMOB_ID_IOS ""
#define ADMOB_INTERSTITIAL_ID_IOS ""
#define GA_TRACKING_ID ""

void NativeBridge::openUrl(const char* url) {
    NSURL* nsUrl = [NSURL URLWithString:[NSString stringWithUTF8String:url]];
    [[UIApplication sharedApplication] openURL:nsUrl];
}

void NativeBridge::loginGameCenter() {
    //for iOS6+
    if (floor(NSFoundationVersionNumber) >= NSFoundationVersionNumber_iOS_6_0){
        GKLocalPlayer* player = [GKLocalPlayer localPlayer];
        UIViewController* rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
        player.authenticateHandler = ^(UIViewController* ui, NSError* error )
        {
            if ( nil != ui ) {
                NSLog(@"Need to login");
                [rootController presentViewController:ui animated:YES completion:nil];
            }
            else if( player.isAuthenticated )
            {
                NSLog(@"Authenticated");
            }
            else
            {
                NSLog(@"Failed");
            }
        };
    } else {
        GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];

        [localPlayer authenticateWithCompletionHandler:^(NSError *error) {
            if (localPlayer.authenticated) {
            } else {
            }
        }];

    }
}

void NativeBridge::openRanking() {
    GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
    if(localPlayer.authenticated){
        UIViewController* rootController = [UIApplication sharedApplication].keyWindow.rootViewController;

        GKLeaderboardViewController* leaderboardController = [[GKLeaderboardViewController alloc] init];
        leaderboardController.timeScope = GKLeaderboardTimeScopeAllTime;
        leaderboardController.leaderboardDelegate = (id<GKLeaderboardViewControllerDelegate>)rootController;

        [rootController presentModalViewController:leaderboardController animated:YES];
        [leaderboardController release];
    }
    else{
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"GameCenterへのログインが必要です。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        [alertView release];
    }
}

void NativeBridge::postHighScore(const char* key, double score) {
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    if([localPlayer isAuthenticated])
    {
        GKScore *gkScore = [[GKScore alloc]initWithCategory:[NSString stringWithUTF8String:key]];
        gkScore.value = score * 100;
        gkScore.context = 1;
        [gkScore reportScoreWithCompletionHandler:^(NSError *error) {
            if(error)
            {
                NSLog(@"Error : %@",error);
            }
            else
            {
                NSLog(@"Sent highscore.");
            }
        }];
    }
    else
    {
        NSLog(@"Gamecenter not authenticated.");
    }
}

void NativeBridge::openAchievement() {
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    if (localPlayer.authenticated) {
        UIViewController* rootController = [UIApplication sharedApplication].keyWindow.rootViewController;

        GKAchievementViewController *achievementController = [[GKAchievementViewController alloc] init];
        achievementController.achievementDelegate = (id<GKAchievementViewControllerDelegate>)rootController;

        [rootController presentModalViewController:achievementController animated:YES];
        [achievementController release];
    } else {
        UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"GameCenterへのログインが必要です。" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alertView show];
        [alertView release];

    }
}

void NativeBridge::postAchievement(const char* key, int percentComplete) {
    GKLocalPlayer *localPlayer = [GKLocalPlayer localPlayer];
    if([localPlayer isAuthenticated])
    {
        GKAchievement *achievement = [[GKAchievement alloc] initWithIdentifier:[NSString stringWithUTF8String:key]];
        achievement.percentComplete = [[NSNumber numberWithInt:percentComplete] doubleValue];
        achievement.showsCompletionBanner = YES;
        [achievement reportAchievementWithCompletionHandler:^(NSError *error) {
            if(error)
            {
                NSLog(@"Error : %@",error);
            }
            else
            {
                NSLog(@"Sent Achievement.");
            }
        }];
    }
    else
    {
        NSLog(@"Gamecenter not authenticated.");
    }
}

void NativeBridge::showAd() {
    GADAdSize size = kGADAdSizeBanner;
    UIViewController* rootController = [UIApplication sharedApplication].keyWindow.rootViewController;

    bannerView = [[GADBannerView alloc] initWithAdSize:size];
    bannerView.adUnitID = [NSString stringWithUTF8String:ADMOB_ID_IOS];
    bannerView.rootViewController = rootController;
    [rootController.view addSubview:bannerView];

    // set position bottom
    CGFloat positionX = rootController.view.bounds.size.width / 2;
    CGFloat positionY = rootController.view.bounds.size.height - bannerView.bounds.size.height / 2;
    [bannerView setCenter:CGPointMake(positionX, positionY)];

    [bannerView loadRequest:[GADRequest request]];
}

void NativeBridge::hideAd() {
    if (nil != bannerView) {
        [bannerView removeFromSuperview];
        [bannerView release];
        bannerView = nil;
    }
}

void NativeBridge::loadInterstitialAd() {
    interstitial = [[GADInterstitial alloc] init];
    interstitial.adUnitID = [NSString stringWithUTF8String:ADMOB_INTERSTITIAL_ID_IOS];
    [interstitial loadRequest:[GADRequest request]];
}

void NativeBridge::showInterstitialAd() {
    UIViewController* rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [interstitial presentFromRootViewController:rootController];
}


void NativeBridge::gaSetup()
{
#if !defined(COCOS2D_DEBUG) || COCOS2D_DEBUG == 0
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;

    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;

    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];

    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:[NSString stringWithUTF8String:GA_TRACKING_ID]];
#endif
}

void NativeBridge::sendScreen(const char* screenName)
{
#if !defined(COCOS2D_DEBUG) || COCOS2D_DEBUG == 0
    // May return nil if a tracker has not already been initialized with a
    // property ID.
    id tracker = [[GAI sharedInstance] defaultTracker];

    // This screen name value will remain set on the tracker and sent with
    // hits until it is set to a new value or to nil.
    [tracker set:kGAIScreenName value:[NSString stringWithUTF8String:screenName]];

    [tracker send:[[GAIDictionaryBuilder createScreenView] build]];
#endif
}

void NativeBridge::postWithImage(const char *message, const char *filePath) {
    NSString *messageStr = [NSString stringWithUTF8String:message];
    NSString *filePathStr = [NSString stringWithUTF8String:filePath];

    UIImage *postImage = [UIImage imageWithContentsOfFile:filePathStr];

    NSArray *activityItems;
    if ([filePathStr length] == 0) {
        activityItems = @[messageStr];
    } else {
        activityItems = @[messageStr, postImage];
    }

    UIActivityViewController *activityController = [[UIActivityViewController alloc]
                                                    initWithActivityItems:activityItems
                                                    applicationActivities:nil];

    UIViewController* rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
    [rootController presentViewController:activityController
                                               animated:YES completion:nil];
}
