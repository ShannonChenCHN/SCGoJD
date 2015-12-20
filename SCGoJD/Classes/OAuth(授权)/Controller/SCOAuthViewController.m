//
//  SCOAuthViewController.m
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCOAuthViewController.h"
#import "SCTabBarController.h"

#import "SCAccount.h"
#import "SCAccountTool.h"

#import "MBProgressHUD+MJ.h"

#define SCAuthorizeURL      @"https://oauth.jd.com/oauth/authorize"
#define SCRedirect_uri      @"http://www.baidu.com"



@interface SCOAuthViewController () <UIWebViewDelegate>

@end

@implementation SCOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 创建webView, 展示登陆页面
    UIWebView *OAuthWebView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    
    // 根据屏幕大小自动调整页面尺寸
    OAuthWebView.scalesPageToFit = YES;
    
    [self.view addSubview:OAuthWebView];
    
    // 2. 请求获取用户授权码code
    NSURLRequest *request = [self creatRequestOfAuthorizeByBaseURL:SCAuthorizeURL
                                                          clientID:SCClient_id
                                                       redirectURI:SCRedirect_uri];

    // 加载登陆请求授权页面
    [OAuthWebView loadRequest:request];
    
    // 设置代理
    OAuthWebView.delegate = self;
}

#pragma mark - 1. 请求用户授权Token
- (NSURLRequest *)creatRequestOfAuthorizeByBaseURL:(NSString *)baseURL
                                          clientID:(NSString *)client_id
                                       redirectURI:(NSString *)redirect_uri
{
    // 一个完整的URL = 基本URL + 请求参数
    // 基本URL:basicURL
    // 参数1：client_id( 新浪提供的AppKey)
    // 参数2：redirect_uri (授权回调地址);
    
    // 拼接URL字符串
    NSString *URLString
    = [NSString stringWithFormat:@"%@?response_type=code&client_id=%@&redirect_uri=%@&view=wap",
       baseURL,
       client_id,
       redirect_uri];
    NSURL *URL = [NSURL URLWithString:URLString];
    
    return [NSURLRequest requestWithURL:URL];
}


#pragma mark - 2.拦截webView请求,截取code,获取访问令牌accessToken
// 在webView将要通过request去加载的时候，就会调用这个方法，询问是否加载请求
- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    // 1. 获取完整地URLString
    NSString *requestURLString = request.URL.absoluteString;
    
    // 2. 获取Request Token授权(登陆之后，点击授权，进入回调页面，获取code=...)
    // 注意：NSRange 不是对象，而是结构体
    
    // 判断URL中是否包含code=...内容
    NSRange rangeOfCode = [requestURLString rangeOfString:@"code="];
    
    if (rangeOfCode.length > 0) { // 如果获取的URL包含code内容的话
        
        // 2.1 获取code内容
        NSString *codeString
        = [requestURLString substringFromIndex:rangeOfCode.location + rangeOfCode.length];
        
        // 2.2 用code换取令牌accessToken
        [self accessTokenByCode:codeString];
        
        // 获取授权成功后，不加载回调页面
        return NO;
    }
    
    // 第一次时，要加载授权页面
    return YES;
}


#pragma mark - 2. 获取access Token（请求授权后的返回数据）
- (void)accessTokenByCode:(NSString *)code
{
    // 获取access Token(只需提供code),并保存账号信息到本地
    [SCAccountTool accountWithCode:code success:^{  // 获取成功时调用
        
        // 进入tabBarVC
        SCTabBarController *tabBarVC = [[SCTabBarController alloc] init];
        
        // 切换keyWindow的根控制器：可以直接把之前的根控制器覆盖掉
        SCKeyWindow.rootViewController = tabBarVC;
        
    } failure:^(NSError *error) {
        SCLog(@"错误信息:%@", error);
    }];
}

#pragma mark - UIWebView代理
#pragma mark 加载等待页面
// 开始加载后调用
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 提示用户正在加载(这里用到了第三方框架)
    [MBProgressHUD showMessage:@"正在拼命加载..."];
}

// 加载完成后调用（第一次加载授权页面时）
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

// 加载失败时调用(第二次不加载回调页面时)
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
}

@end
