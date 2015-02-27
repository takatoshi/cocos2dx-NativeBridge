package com.tactsh;

import org.cocos2dx.lib.Cocos2dxActivity;
import android.content.Intent;
import android.net.Uri;
import android.os.Handler;
import android.app.Activity;
import android.view.WindowManager;
import android.view.Gravity;

import com.google.android.gms.ads.*;
import com.google.android.gms.analytics.*;

public class NativeBridgeHelper {
  public static AdView adView;
  public static InterstitialAd interstitial;
  public static Tracker mTracker;

  public static void openUrl(String url) {
    Intent intent = new Intent();
    intent.setAction(Intent.ACTION_VIEW);
    intent.setData(Uri.parse(url));
    try {
      ((Activity)Cocos2dxActivity.getContext()).startActivityForResult(intent, 0);
    } catch (Exception e) {
    }
  }

  public static void showAd() {
      Activity mContext = (Activity) Cocos2dxActivity.getContext();
      Handler mainHandler = new Handler(mContext.getMainLooper());
      Runnable r = new Runnable() {
          public void run() {
              Activity mContext = (Activity) Cocos2dxActivity.getContext();
              AdSize size = AdSize.BANNER;
              adView = new AdView(mContext);
              adView.setAdSize(size);
              adView.setAdUnitId("");

              WindowManager mWm = (WindowManager) mContext.getSystemService("window");
              WindowManager.LayoutParams mLayoutParams = new WindowManager.LayoutParams();
              mLayoutParams.type = WindowManager.LayoutParams.TYPE_APPLICATION_PANEL;
              mLayoutParams.width = WindowManager.LayoutParams.WRAP_CONTENT;
              mLayoutParams.height = WindowManager.LayoutParams.WRAP_CONTENT;
              mLayoutParams.flags |= WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE;
              mLayoutParams.gravity = Gravity.BOTTOM;
              mWm.addView(adView, mLayoutParams);

              AdRequest adRequest = new AdRequest.Builder().build();
              adView.loadAd(adRequest);
          }
      };
      if (mainHandler != null) {
          mainHandler.post(r);
      } else if (mContext != null && mContext instanceof Activity) {
          Activity act = (Activity) mContext;
          act.runOnUiThread(r);
      }
  }

  public static void hideAd() {
      Activity mContext = (Activity) Cocos2dxActivity.getContext();
      Handler mainHandler = new Handler(mContext.getMainLooper());
      Runnable r = new Runnable() {
          public void run() {
              Activity mContext = (Activity) Cocos2dxActivity.getContext();
              WindowManager mWm = (WindowManager) mContext.getSystemService("window");
              if (adView != null) {
                  if (mContext != null) {
                      mWm.removeView(adView);
                  }
                  adView.destroy();
                  adView = null;
              }
          }
      };
      if (mainHandler != null) {
          mainHandler.post(r);
      } else if (mContext != null && mContext instanceof Activity) {
          Activity act = (Activity) mContext;
          act.runOnUiThread(r);
      }
  }

  public static void loadInterstitialAd() {
      Activity mContext = (Activity) Cocos2dxActivity.getContext();
      Handler mainHandler = new Handler(mContext.getMainLooper());
      Runnable r = new Runnable() {
          public void run() {
              Activity mContext = (Activity) Cocos2dxActivity.getContext();
              interstitial = new InterstitialAd(mContext);
              interstitial.setAdUnitId("");

              AdRequest adRequest = new AdRequest.Builder().build();

              interstitial.loadAd(adRequest);
          }
      };
      if (mainHandler != null) {
          mainHandler.post(r);
      } else if (mContext != null && mContext instanceof Activity) {
          Activity act = (Activity) mContext;
          act.runOnUiThread(r);
      }
  }

  public static void showInterstitialAd() {
      Activity mContext = (Activity) Cocos2dxActivity.getContext();
      Handler mainHandler = new Handler(mContext.getMainLooper());
      Runnable r = new Runnable() {
          public void run() {
              if (interstitial.isLoaded()) {
                interstitial.show();
              }
          }
      };
      if (mainHandler != null) {
          mainHandler.post(r);
      } else if (mContext != null && mContext instanceof Activity) {
          Activity act = (Activity) mContext;
          act.runOnUiThread(r);
      }
  }

  public static void gaSetup() {
	  if (mTracker == null) {
		  GoogleAnalytics analytics = GoogleAnalytics.getInstance(Cocos2dxActivity.getContext().getApplicationContext());
		  mTracker = analytics.newTracker(R.xml.global_tracker);
	  }
  }

  public static void sendScreen(String screenName) {
      // Set screen name.
      // Where path is a String representing the screen name.
      mTracker.setScreenName(screenName);

      // Send a screen view.
      mTracker.send(new HitBuilders.AppViewBuilder().build());

  }
}
