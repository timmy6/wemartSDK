package cn.wemart.sample;

import android.content.Intent;
import android.os.Bundle;
import android.support.v7.app.AppCompatActivity;
import android.view.View;

import cn.wemart.sdk.activity.MallActivity;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
    }

    public void start(View v) {
        Intent intent = new Intent(this, MallActivity.class);
        intent.putExtra("url", "http://www.wemart.cn/mobile/?chanId=&shelfNo=1634&native=false&payNative=true&sellerId=97&a=shelf&m=index&scenType=1&appId=16&userId=jamesapp-test01&sign=hqvQYdb4ge+FhYgGn5L5iVz9d7nnpS0uk6O43ULLsOiG3FHh6S9uHtHu0MJkwyJCjIcLeS3xGKcAeIKev72a+U45Q1yz1982cElpRQuGIUkD5rSm5H69jY1xcBzzLTPcPSHt4wzx14FBuKIqcrhfGM14EhU51fLFP8pzPQAxp9E="); // 店铺货架
//        intent.putExtra("title","微猫商城");  非必须参数，默认title为微猫商城
//        intent.putExtra("statusBarColor","xxx");  非必须参数
        startActivity(intent);
    }
}