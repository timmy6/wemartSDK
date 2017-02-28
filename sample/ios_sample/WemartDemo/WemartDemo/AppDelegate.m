//
//  AppDelegate.m
//  WemartDemo
//
//  Created by 冯文秀 on 16/7/5.
//  Copyright © 2016年 冯文秀. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

// 引入支付宝SDK  实现支付宝支付回调
#import <AlipaySDK/AlipaySDK.h>

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    ViewController *Vc = [[ViewController alloc]init];
    // 支付宝白名单标识 依据个人设置
    Vc.appScheme = @"WemartSDK";
    // 自收，则传从微信申请获得的微信AppId； 平台代收，不用传值；
//    Vc.wechatAppId = @"wx1abc23d4ef5678a90"; // (此处AppId不可用，仅为示例, 自收替换成您的微信AppId)

    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Vc];
    nav.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    // 设置根视图控制器
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];


    return YES;
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
