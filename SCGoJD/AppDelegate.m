//
//  AppDelegate.m
//  SCGoJD
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "AppDelegate.h"

#import "SCNewFeatureController.h"

#import "SCAppVersionTool.h"
#import "SCRootVCSelectionTool.h"

#import "UIImageView+WebCache.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 创建window
    self.window = [[UIWindow alloc] initWithFrame:SCMainScreenBounds];
    
   //设置根控制器
    [self setRootViewControllerForKeyWindow];
    
    // 显示主窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - 设置根控制器
- (void)setRootViewControllerForKeyWindow {
    // 1. 获取当前版本信息
    NSString *currentBundleVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleVersion"];

    // 2. 判断当前版本是否是最新
    if ([currentBundleVersion isEqualToString:[SCAppVersionTool savedAppVersion]]) {    // 3.1 如果不是新版本

        // 由授权控制器决定窗口的根控制器
        [SCRootVCSelectionTool setRootViewControllerForWindow:self.window];
        
    } else {                                            // 3.2 如果是新版本
    
        // 1. 保存新版本信息（偏好设置)
        [SCAppVersionTool saveNewAppVersion:currentBundleVersion];
        
        // 2. 创建新特性画面控制器collectionViewController
        SCNewFeatureController *newFeatureVC = [[SCNewFeatureController alloc] init];
        // 设置窗口的根控制器
        self.window.rootViewController = newFeatureVC;
    }
}

#pragma mark - 注意：收到内存警告时调用，
- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{
    // 1. 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    
    // 2. 清除缓存
    [[SDWebImageManager sharedManager].imageCache clearMemory];
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
