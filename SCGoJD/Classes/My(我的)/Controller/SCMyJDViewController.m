//
//  SCMyJDViewController.m
//  SCGoJD
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCMyJDViewController.h"

@interface SCMyJDViewController ()

@end

@implementation SCMyJDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 设置两侧按钮
    [self setBarButtonItems];
}

// 设置两侧按钮
- (void)setBarButtonItems {
    
    // 左侧设置按钮
    self.navigationItem.leftBarButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage imageNamed:@"my_more_btn_n"]
                                       highlightedImage:[UIImage imageNamed:@"my_more_btn_h"]
                                                 target:self
                                                 action:@selector(setttings:)
                                       forControlEvents:UIControlEventTouchUpInside];
    
    // 右侧消息按钮
    self.navigationItem.rightBarButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage imageNamed:@"my_message_btn_n"]
                                       highlightedImage:[UIImage imageNamed:@"my_message_btn_h"]
                                                 target:self
                                                 action:@selector(checkMyMessage:)
                                       forControlEvents:UIControlEventTouchUpInside];
    
}

// 点击设置
- (void)setttings:(UIButton *)button {
    
}

// 点击消息按钮
- (void)checkMyMessage:(UIButton *)button {
    
}

@end
