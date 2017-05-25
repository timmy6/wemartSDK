//
//  AppDelegate.m
//  WemartDemo
//
//  Created by liuqiming on 17/5/5.
//  Copyright © 2016年 liuqiming. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import <WemartSDK/WemartSDK.h>

// 引入支付宝SDK  实现支付宝支付回调
#import <AlipaySDK/AlipaySDK.h>

#import <WemartSDK/WemartSDK.h>
#define WemartTestUrl  @"http://www.wemart.cn/mobile/?chanId=&shelfNo=1634&native=false&payNative=true&sellerId=97&a=shelf&m=index&scenType=1&appId=16&userId=jamesapp-test01&sign=hqvQYdb4ge+FhYgGn5L5iVz9d7nnpS0uk6O43ULLsOiG3FHh6S9uHtHu0MJkwyJCjIcLeS3xGKcAeIKev72a+U45Q1yz1982cElpRQuGIUkD5rSm5H69jY1xcBzzLTPcPSHt4wzx14FBuKIqcrhfGM14EhU51fLFP8pzPQAxp9E=&payNative=true&native=false"
@interface AppDelegate ()

@property(nonatomic, strong) WemartViewController *mWemartVc;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *vc = [[ViewController alloc]init];
    
    //-----WemartSDK设置-----
    WemartViewController *wemartVc = [[WemartViewController alloc] init];
    wemartVc.appScheme = @"scheme"; //支付宝白名单scheme设置
    wemartVc.wechatAppId = @"xxxxxxxx";    //如果收款方式是平台代收，不需要配置；如果是自己收款，填写微信开发者平台对应的AppId
    //    wemartVc.hidStatus = YES; 若App工程有全局隐藏导航栏的需求，设置hidStatus为YES, 默认为NO
    wemartVc.shopUrl = WemartTestUrl;   // 替换成自己店铺的url 测试demo
    //    wemartVc.WMHidden = YES;  主页面是否显示返回按钮，YES隐藏 NO显示; 不传则默认为NO，即不隐藏
    vc.wemartVc = wemartVc;
    self.mWemartVc = wemartVc;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wemartShare:) name:KWemartShareNotice object:nil]; //设置SDK右上角按钮通知接收回调
    //-----WemartSDK设置end---
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:vc];
    
    // 设置根视图控制器
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void) wemartShare:(NSNotification *) notification{
    
}

// 支付宝原生支付处理，代码如下（直接复制使用，协助完成支付宝原生支付回调）
#pragma mark --- 支付宝支付相关 ---
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result 钱包 9.0qian ========= %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wemartConfigureWithPayResult" object:resultDic];
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){
        //支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result 快登 9.0qian ========= %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wemartConfigureWithPayResult" object:resultDic];
        }];
    }
    return YES;
}

// 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result 钱包 9.0hou ===== %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wemartConfigureWithPayResult" object:resultDic];
            
        }];
    }
    if ([url.host isEqualToString:@"platformapi"]){
        //支付宝钱包快登授权返回 authCode
        [[AlipaySDK defaultService] processAuthResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result 快登 9.0hou ===== %@",resultDic);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wemartConfigureWithPayResult" object:resultDic];
            
        }];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
