package cn.wemart.sample;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.util.Log;

/**
 * Created by Timmy on 2017/2/13.
 */

public class WXPayBroadCast extends BroadcastReceiver {
    @Override
    public void onReceive(Context context, Intent intent) {
        String content = intent.getStringExtra("data");
        Log.d("wxpay", content);
    }
}