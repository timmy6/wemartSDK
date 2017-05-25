//
//  ViewController.m
//  WemartDemo
//
//  Created by liuqiming on 17/5/5.
//  Copyright © 2016年 liuqiming. All rights reserved.
//

#import "ViewController.h"
#import <WemartSDK/WemartViewController.h>
#define KScreenWidth [UIScreen mainScreen].bounds.size.width

#define WemartTestUrl  @"http://www.wemart.cn/mobile/?chanId=&shelfNo=1634&native=false&payNative=true&sellerId=97&a=shelf&m=index&scenType=1&appId=16&userId=jamesapp-test01&sign=hqvQYdb4ge+FhYgGn5L5iVz9d7nnpS0uk6O43ULLsOiG3FHh6S9uHtHu0MJkwyJCjIcLeS3xGKcAeIKev72a+U45Q1yz1982cElpRQuGIUkD5rSm5H69jY1xcBzzLTPcPSHt4wzx14FBuKIqcrhfGM14EhU51fLFP8pzPQAxp9E=&payNative=true&native=false"

@interface ViewController ()

@end

@implementation ViewController

- (void)dealloc {
    NSLog(@"viewController dealloc");
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Wemart";
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake((KScreenWidth - 100)/2, 100, 100, 30)];
    button.backgroundColor = [UIColor lightGrayColor];
    [button setTitle:@"跳转" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(enterAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)enterAction
{
    if (self.wemartVc) {
        [self.navigationController pushViewController:self.wemartVc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
