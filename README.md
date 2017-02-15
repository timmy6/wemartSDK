---
title: wemartSDK 集成文档
date: 2017-02-11 16:18:43
author: james/timmy
---

### (一)导入wemartSDK aar和alipaySDK.jar(支付宝SDK)文件
在library/androidSDK中找到wemartSDK.aar文件，将wemartSDK加入项目中的lib文件夹；下载alipaySDK.jar(支付宝SDK)或者在library/androidSDK里拷贝alipaySDK.jar.
**注意:如果APP项目已经包含了支付宝SDK，请确认支付宝SDK文件名是否是alipaySDK.jar，如果不是，请将文件名修改成alipaySDK.jar，否则调起支付宝支付时，会报找不到alipaySDK文件的错误**
### (二)Android Studio导入wemart.aar文件配置
在app的build.gradle文件中，添加：
```java
repositories {
    flatDir {
        dirs 'libs'
    }
}
```
在dependencies中，添加：
```java
    compile files('libs/alipaySdk.jar')
    compile(name: 'wemartSDK', ext: 'aar')
```
配置之后的app build.gradle内容如下图
![app_build_gradle](/static/wemart_build_gradle.png)

### (三)权限配置
在AndroidMainifest.xml文件中，加入如下权限：
```java
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```

### (四)配置商城入口url
- **获取店铺主页**。登陆微猫后台————>店铺————>预览。预览后，点击右侧蓝色“复制链接按钮”，存下来。如下图
![wemart_sdk2](/static/wemart_sdk1.png)
![wemart_sdk3](/static/wemart_sdk3.png)

获取到店铺主页链接: http://www.wemart.cn/mobile/?chanId=110&shelfNo=xxx&sellerId=xxx&a=shelf&m=index

-. **获取店铺App Id**。点击左上方“店铺设置”或者“平台设置”————>点击左侧“场景“————>点击蓝色按钮“创建APP“并输入APP名字，保存，保存成功后，即可看到APPID
![wemart_sdk4](/static/wemart_sdk4.png)
![wemart_sdk5](/static/wemart_sdk5.png)
![wemart_sdk6](/static/wemart_sdk6.png)

- **添加url参数**。在主页链接后面，添加必需的url参数：scenType=1&appId=xxx&userId=xxx&sign=xxx&native=false&payNative=true。
其中，userId为应用对应用户的唯一标识；sign参数为对字符串“appId = xxx&userId=xxx”进行RSA-SHA1签名，签名需要的私钥（即AppSecret）在AppId下方，获取方法参考上方**获取店铺App Id**步骤。
**完整的商城入口url为：http://www.wemart.cn/mobile/?chanId=&shelfNo=xxx&sellerId=xxx&a=shelf&m=index&native=false&payNative=true&scenType=1&appId=xxx&userId=xxx&sign=xxx**

**注意：上方“xxx”需用相应的值替换**

### (五)注册接收**微信支付和分享的广播**
- **微信支付参数获取**。创建一个继承BroadcastReceiver的子类，且在AndroidManifest.xml注册该广播，action为:”cn.wemart.sdk.share”。
![wemart_sdk7](/static/wemart_sdk9.png)

获取微信支付参数的示例代码如下：
![wemart_sdk8](/static/wemart_sdk8.png)

- **分享**。 创建一个继承BroadcastReceiver的子类，且在AndroidManifest.xml注册该广播，action为:”cn.wemart.sdk.share”。
![wemart_sdk9](/static/wemart_sdk10.png)

获取分享参数的示例代码如下：
![wemart_sdk10](/static/wemart_sdk11.png)

**注意:微信支付和分享SDK只提供内容.获取到微信支付参数后，需要APP自己调起微信支付；分享也是需要APP自己调起分享，wemartSDK只提供支付参数和分享内容**

### (六)使用SDK
```java
Intent intent = new Intent(context,MallActivity.class);
intent.putExtra(“url”,xxx);	//xxx为商城入口url
startActivity(intent);
```