---
title: wemartSDK 集成文档
date: 2017-02-11 16:18:43
author: james/hera/timmy
---

> android 和iOS获取参数方法相同.

## 配置商城入口url
- **获取店铺主页**。登陆微猫后台————>店铺————>预览。预览后，点击右侧蓝色“复制链接按钮”，存下来。如下图
![wemart_sdk2](/static/wemart_sdk1.png)
![wemart_sdk3](/static/wemart_sdk3.png)

获取到店铺主页链接: http://www.wemart.cn/mobile/?chanId=110&shelfNo=xxx&sellerId=xxx&a=shelf&m=index

- **获取店铺App Id**。点击左上方“店铺设置”或者“平台设置”————>点击左侧“场景“————>点击蓝色按钮“创建APP“并输入APP名字，保存，保存成功后，即可看到APPID
![wemart_sdk4](/static/wemart_sdk4.png)
![wemart_sdk5](/static/wemart_sdk5.png)
![wemart_sdk6](/static/wemart_sdk6.png)

- **添加url参数**。在主页链接后面，添加必需的url参数：scenType=1&appId=xxx&userId=xxx&sign=xxx&native=false&payNative=true。
其中，userId为应用对应用户的唯一标识；sign参数为对字符串“appId = xxx&userId=xxx”进行RSA-SHA1签名，签名需要的私钥（即AppSecret）在AppId下方，获取方法参考上方**获取店铺App Id**步骤。
**完整的商城入口url为：http://www.wemart.cn/mobile/?chanId=110&shelfNo=xxx&sellerId=xxx&a=shelf&m=index&native=false&payNative=true&scenType=1&appId=xxx&userId=xxx&sign=xxx**

**注意：上方“xxx”需用相应的值替换**

## wemart Android SDK 集成

### (1)导入wemartSDK aar和alipaySDK.jar(支付宝SDK)文件
在library/androidSDK中找到wemartSDK.aar文件，将wemartSDK加入项目中的lib文件夹；下载alipaySDK.jar(支付宝SDK)或者在library/androidSDK里拷贝alipaySDK.jar.
**注意:如果APP项目已经包含了支付宝SDK，请确认支付宝SDK文件名是否是alipaySDK.jar，如果不是，请将文件名修改成alipaySDK.jar，否则调起支付宝支付时，会报找不到alipaySDK文件的错误**
### (2)Android Studio导入wemart.aar文件配置
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

### (3)权限配置
在AndroidMainifest.xml文件中，加入如下权限：
```java
    <uses-permission android:name="android.permission.INTERNET" />
    <uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
```

### (4)注册接收**微信支付和分享的广播**
- **微信支付参数获取**。创建一个继承BroadcastReceiver的子类，且在AndroidManifest.xml注册该广播，action为:”cn.wemart.sdk.share”。
![wemart_sdk7](/static/wemart_sdk9.png)

获取微信支付参数的示例代码如下：
![wemart_sdk8](/static/wemart_sdk8.png)

- **分享**。 创建一个继承BroadcastReceiver的子类，且在AndroidManifest.xml注册该广播，action为:”cn.wemart.sdk.share”。
![wemart_sdk9](/static/wemart_sdk10.png)

获取分享参数的示例代码如下：
![wemart_sdk10](/static/wemart_sdk11.png)

**注意:微信支付和分享SDK只提供内容.获取到微信支付参数后，需要APP自己调起微信支付；分享也是需要APP自己调起分享，wemartSDK只提供支付参数和分享内容**

### (5)使用SDK
```java
Intent intent = new Intent(context,MallActivity.class);
intent.putExtra(“url”,xxx);	//xxx为商城入口url
startActivity(intent);
```

## wemart iOS SDK集成（SDK仅支持iOS 8.0及以上）
说明：1）如您的App工程中已含有支付宝以及微信SDK，则按照集成步骤操作；
 2）如您的App工程中仅含有支付宝或微信SDK之一，请加入您缺少的**AliPay-o**文件夹中的文件或**WeChat-o**文件夹中的文件，然后按照集成步骤操作；
 3）如您的App工程中支付宝和微信SDK均无，则请先加入您缺少的**AliPay-o**文件夹中的文件以及**WeChat-o**文件夹中的文件，然后按照集成步骤操作；
 
### (1)导入WemartSDK.framework和Wemart.bundle
 在APP工程中导入WemartSDK.framework（静态库）（**注意：区分Debug环境下 和 Release环境下的.framework，保证对应环境使用**）以及Wemart.bundle（bundle资源文件），添加时记得勾选 Copy items if needed，然后参照下图，选中工程 **Targat —> General —> Linked Frameworks and Libraries —>  +**，在输入框中，输入下图中需要的框架，选中并添加

![wemart_ios_sdk1](/static/wemart_ios_sdk1.png)

### (2)设置起始控制器以及支付宝、微信的相关参数
以导航控制器为起始控制器，设置**appScheme**、**wechatAppId**（微信appId，**注意：自收，则传从微信申请获得的微信AppId；平台代收，不用传值**），如图（示例Demo中的**AppDelegate.m**文件中可查看代码）。另外，在**WemartViewController**中，保留了商城分享信息，请注意需在界面加载完成后，才可使用分享数据。

![wemart_ios_sdk2](/static/wemart_ios_sdk2.png)

![wemart_ios_sdk3](/static/wemart_ios_sdk3.png)

### (3)支付宝的appScheme配置
需要配置支付宝的**appScheme**，在 **Target —> Info —> URL Type —>  + **，添加URL Schemes 名称（**注意：要与赋值给WemartViewController的appScheme保持一致**），以确保支付后能回调回自己的App（尽量保持唯一，避免以其他App的标识混淆），如下图

![wemart_ios_sdk4](/static/wemart_ios_sdk4.png)

### (4)微信的scheme配置
选中 **Info.plist** 右键 —> **Open As** —> **Source Code**，增加如下代码，打开权限：
```objc
    <key>LSApplicationQueriesSchemes</key>
    <array>
        <string>wechat</string>
        <string>weixin</string>
    </array>
```

![wemart_ios_sdk5](/static/wemart_ios_sdk5.png)

### (5)赋值商城店铺url入口
将按照文档要求配置好的，商城入口url赋值给Demo中wemartVc的shopUrl（**注意必填**），将跳转微猫商城的事件写在App工程想要实现的事件中，目标控制器即要显示商城的控制器，如若App工程有全局隐藏导航栏的需求，可设置wemartVc的hidStatus属性为YES，WHHidden可以隐藏主页返回按钮如下图：

![wemart_ios_sdk6](/static/wemart_ios_sdk6.png)


### (6)**注意事项**
1)若使用支付宝原生支付，需在AppDelegate.m中参照Demo，实现以下两个方法（配合支付宝客户端回调）

```objc
// 9.0之前的API接口
- (BOOL)application:(UIApplication *)application  openURL:(NSURL *)url  sourceApplication:(NSString *)sourceApplication   annotation:(id)annotation；
// 9.0以后使用新API接口
(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options；
```

2) 若工程接入SDK后界面空白，可在App工程下的“Info.plist”中，下检查是否已将要使用的URL Schemes列为白名单。若无，可直接添加：先添加 App Transport Security Settings 字典，再在字典下添加键值对 Allow Arbitrary Loads ：YES ,效果如图：

![wemart_ios_sdk7](/static/wemart_ios_sdk7.png)

也可以选中 **Info.plist** 右键 —> **Open As** —> **Source Code** ，增加如下代码：
```objc
    <key>NSAppTransportSecurity</key>
    <dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
    </dict>
```