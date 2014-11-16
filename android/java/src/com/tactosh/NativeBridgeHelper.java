package com.tactosh;

import org.cocos2dx.lib.Cocos2dxActivity;
import android.content.Intent;
import android.net.Uri;
import android.app.Activity;

public class NativeBridgeHelper {
  public static void openUrl(String url) {
    Intent intent = new Intent();
    intent.setAction(Intent.ACTION_VIEW);
    intent.setData(Uri.parse(url));
    try {
      ((Activity)Cocos2dxActivity.getContext()).startActivityForResult(intent, 0);
    } catch (Exception e) {
    }
  }
}
