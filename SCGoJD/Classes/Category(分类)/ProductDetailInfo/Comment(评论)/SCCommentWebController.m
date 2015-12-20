//
//  SCCommentWebController.m
//  SCGoJD
//
//  Created by mac on 15/9/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCommentWebController.h"

#define SCProductCommentURL      @"http://item.m.jd.com/comments/skuId.html?sid=032a046ef0a7f73b4be6ba7a050a69fc"

@interface SCCommentWebController ()

// 商品编号skuId
@property (nonatomic, copy) NSString *skuId;

@end

@implementation SCCommentWebController

#pragma mark -初始化
- (instancetype)initWithSkuId:(NSString *)skuId {
    self = [super init];
    
    if (self) {
        _skuId = skuId;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 1. 创建webView, 展示评论页面
    UIWebView *detailWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    // 根据屏幕大小自动调整页面尺寸
    detailWebView.scalesPageToFit = YES;
    
    [self.view addSubview:detailWebView];
    
    // 2. 设置请求URL
    NSString *URLString = SCProductCommentURL;
    URLString = [URLString stringByReplacingOccurrencesOfString:@"skuId" withString:_skuId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    
    // 加载页面
    [detailWebView loadRequest:request];
}


@end
