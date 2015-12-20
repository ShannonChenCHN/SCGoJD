//
//  SCNavigationController.m
//  SCGoJD
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCNavigationController.h"

#define SCNavigationBarTitleFont [UIFont systemFontOfSize:18]
#define SCNavigationBarButtonFont [UIFont systemFontOfSize:14]

@interface SCNavigationController () <UINavigationControllerDelegate>

@end

@implementation SCNavigationController

//一初始化该类，就会调用该方法
+ (void)initialize
{
    //1.获取当前类下全局的UIBarButtonItem, 这里的self指[SCNavigationController class]
    UIBarButtonItem *allNavigationItem = [UIBarButtonItem appearanceWhenContainedIn:self, nil];
    //设置按钮标题颜色、字体
    NSMutableDictionary *textAttributeForButton = [NSMutableDictionary dictionary];
    textAttributeForButton[NSForegroundColorAttributeName] = [UIColor grayColor];
    textAttributeForButton[NSFontAttributeName] = SCNavigationBarButtonFont;
    
    [allNavigationItem setTitleTextAttributes:textAttributeForButton forState:UIControlStateNormal];
    
    //2.获取当前类下全局的NavigationBar, 这里的self指[UINavigationController class]
    UINavigationBar *allNavigationBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    //设置标题字体
    NSMutableDictionary *textAttributeForTitle = [NSMutableDictionary dictionary];
    textAttributeForTitle[NSFontAttributeName] = SCNavigationBarTitleFont;
    
    [allNavigationBar setTitleTextAttributes:textAttributeForTitle];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航条背景图片
    [self.navigationBar setBackgroundImage:[UIImage stretchableImageNamed:@"bg_white_top"] forBarMetrics:UIBarMetricsDefault];
     
    // 设置UINavigationControllerDelegate为self
    self.delegate = self;
    
}

#pragma mark - 实现delegate中的方法
// 清除系统tabBarButton上的badgeView (每次导航控制器跳转时显示VC前都会调用)
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated
{
    //获取主窗口的根控制器tabBarController
    UITabBarController *tabBarController = (UITabBarController *)SCKeyWindow.rootViewController;
    
    // 移除系统tabBarButton上的badgeView
    for (UIView *view in tabBarController.tabBar.subviews) { 
        
        for (UIView *subview in view.subviews) {
            
            if ([subview isKindOfClass: NSClassFromString(@"_UIBadgeView")]) {

                [subview removeFromSuperview];
            }
        }
    }
}

@end
