//
//  SCHomeViewController.m
//  SCGoJD
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCHomeViewController.h"
#import "SCSearchBar.h"

#define SCHomePage      @"http://m.jd.com/?cu=true&utm_source=shenma-pinzhuan&utm_medium=cpc&utm_campaign=t_288551095_shenmapinzhuan&amp;utm_term=457da7d9c3fa45ebb2ead137d42333bb_0_1d3ddf95605e417280d9b9145f7beb4e"

@interface SCHomeViewController ()

@end

@implementation SCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置导航条
    [self setNavigationBar];
    
    // 1. 创建webView, 展示京东首页
    UIWebView *homeWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    // 根据屏幕大小自动调整页面尺寸
    homeWebView.scalesPageToFit = YES;
    
    [self.view addSubview:homeWebView];
    
    // 2. 设置请求URL
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:SCHomePage]];
    
    // 加载页面
    [homeWebView loadRequest:request];
}

// 设置导航条
- (void)setNavigationBar {
    
    // 1. 创建searchBar
    SCSearchBar *searchBar = [[SCSearchBar alloc] init];

    searchBar.placeholder = @"iPhone6s震撼来袭";
    // 2. 中间添加searchBar
    [self.navigationController.navigationBar addSubview:searchBar];
    
    // 3. 左侧二维码
    self.navigationItem.leftBarButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage imageNamed:@"find_icon_sao"]
                                       highlightedImage:nil
                                                 target:self
                                                 action:@selector(scanQRCode:)
                                       forControlEvents:UIControlEventTouchUpInside];
    
    // 4. 右侧消息按钮
    self.navigationItem.rightBarButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage originalImageNamed:@"my_message_btn_n"]
                                       highlightedImage:nil
                                                 target:self
                                                 action:@selector(checkMyMessage:)
                                       forControlEvents:UIControlEventTouchUpInside];
    
}

// 扫一扫
- (void)scanQRCode:(UIButton *)button {
    
    
}

// 点击消息按钮
- (void)checkMyMessage:(UIButton *)button {
    
}

@end
