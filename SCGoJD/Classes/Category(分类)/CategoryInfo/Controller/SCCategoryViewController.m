//
//  SCCategoryViewController.m
//  SCGoJD
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCategoryViewController.h"
#import "SCCategoryCommon.h"
#import "SCSearchBar.h"

#import "SCCategoryMenuController.h"
#import "SCCategoryDetailController.h"

@interface SCCategoryViewController ()

// 分类主菜单（必须设为全局的）
@property (nonatomic, strong) SCCategoryMenuController *categoryMenuVC;
// 详细分类列表
@property (nonatomic, strong) SCCategoryDetailController *categoryDetailVC;

@end

@implementation SCCategoryViewController

#pragma mark - 懒加载
- (SCCategoryMenuController *)categoryMenuVC {
    
    if (_categoryMenuVC == nil) {
        _categoryMenuVC = [[SCCategoryMenuController alloc] init];
    }
    
    return _categoryMenuVC;
}

- (SCCategoryDetailController *)categoryDetailVC {
    
    if (_categoryDetailVC == nil) {
        _categoryDetailVC = [[SCCategoryDetailController alloc] init];
    }
    
    return _categoryDetailVC;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    // 1. 设置导航条
    [self setNavigationBar];
    
    // 2. 添加分类主菜单
    [self addCategoryMenuView];
    
    // 3. 添加详细分类列表
    [self addCategoryDetailCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 恢复tabBar
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - 设置导航条
- (void)setNavigationBar {
    
    // 1. 创建searchBar
    SCSearchBar *searchBar
    = [[SCSearchBar alloc] initWithFrame:CGRectMake(15,
                                                    7,
                                                    SCMainScreenBounds.size.width - 75,
                                                    30)];
    searchBar.placeholder = @"iPhone6s震撼来袭";
    // 2. 中间添加searchBar
    [self.navigationController.navigationBar addSubview:searchBar];
//    self.navigationItem.titleView = searchBar;
    // 3. 右侧二维码
    self.navigationItem.rightBarButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage originalImageNamed:@"find_icon_sao"]
                                       highlightedImage:nil
                                                 target:self
                                                 action:@selector(scanQRCode:)
                                       forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - 扫一扫
- (void)scanQRCode:(UIButton *)button {
    
    
}

#pragma mark - 添加一级分类菜单
- (void)addCategoryMenuView {
    
    
    // 计算分类主菜单视图尺寸
    CGFloat x = 0;
    CGFloat y = 0;//self.navigationController.navigationBar.frameHeight + SCStatusBarHeight;
    CGFloat width = SCCategoryMenuWidth;
    CGFloat height = self.view.frameHeight - y;

    self.categoryMenuVC.tableView.frame = CGRectMake(x, y, width, height);
    [self.view addSubview:_categoryMenuVC.tableView];
}

#pragma mark - 添加详细分类列表
- (void)addCategoryDetailCollectionView {
    
    // 计算详细分类列表视图尺寸
    CGFloat x = CGRectGetMaxX(self.categoryMenuVC.tableView.frame);
    CGFloat y = self.categoryMenuVC.tableView.originY;
    CGFloat width = self.view.frameWidth - SCCategoryMenuWidth;
    CGFloat height = self.view.frameHeight - y;
    
    self.categoryDetailVC.view.frame = CGRectMake(x, y, width, height);

    [self.view addSubview:_categoryDetailVC.view];
    
}


@end
