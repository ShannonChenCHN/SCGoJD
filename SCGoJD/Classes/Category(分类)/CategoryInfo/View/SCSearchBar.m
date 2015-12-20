//
//  SCSearchBar.m
//  SCGoJD
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCSearchBar.h"

@implementation SCSearchBar

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        // 设置字体
        self.font = [UIFont systemFontOfSize:13];
        
        // 设置背景
        self.background = [UIImage stretchableImageNamed:@"searchbar_textfield_background"];
        
        // 设置左边的view
        [self setLeftView];
        
        // 设置右边的录音按钮
        [self setRightView];
        
    }
    
    return self;
}

- (instancetype)init {
    // 设置frame
    CGFloat width = SCMainScreenBounds.size.width - 110;
    CGFloat height = 30;
    CGFloat X = (SCMainScreenBounds.size.width - width) * 0.5;
    CGFloat Y = 7;
    CGRect frame = CGRectMake(X, Y, width, height);
    
    return [self initWithFrame:frame];
}

// 设置左边的view
- (void)setLeftView {
    
    // initWithImage:默认UIImageView的尺寸跟图片一样
    UIImageView *leftImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_search_bar_7_write"]];
    
    
    self.leftView = leftImageView;
    //  注意：一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
    self.leftViewMode = UITextFieldViewModeAlways;
}

// 设置右边的view
- (void)setRightView {
    // 创建按钮
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:[UIImage imageNamed:@"audio_nav_icon"] forState:UIControlStateNormal];
    [rightButton sizeToFit];
    // 将imageView宽度
    rightButton.frameWidth += 10;
    //居中
    rightButton.contentMode = UIViewContentModeCenter;
    
    
    self.rightView = rightButton;
    //  注意：一定要设置，想要显示搜索框左边的视图，一定要设置左边视图的模式
    self.rightViewMode = UITextFieldViewModeAlways;}


@end
