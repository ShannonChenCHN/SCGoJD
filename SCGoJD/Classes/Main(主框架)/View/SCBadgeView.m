//
//  SCBadgeView.m
//  SCGoJD
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCBadgeView.h"

#define SCBadgeNumberFontSize [UIFont systemFontOfSize:8]

@implementation SCBadgeView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        // 不允许点击
        self.userInteractionEnabled = NO;
        
        // 设置字体
        self.titleLabel.font = SCBadgeNumberFontSize;
        
        // 设置居右
        self.titleLabel.textAlignment = NSTextAlignmentRight;
        
        // 字体颜色
        [self setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    }
    
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue
{
    // 设置属性
    _badgeValue = badgeValue;
    
    // 设置badgeView内容
    [self setBadgeViewWithbadgeValue:badgeValue];
}

- (void)setBadgeViewWithbadgeValue:(NSString *)badgeValue {
    // 设置文字内容
    [self setTitle:badgeValue forState:UIControlStateNormal];
    
    // 判断是否有内容,设置隐藏属性
    if (badgeValue.length == 0 ||
        [badgeValue isEqualToString:@"0"]) {
        
        // 数值内容为空或数值为0，则隐藏
        self.hidden = YES;
    }
    else {
        self.hidden = NO;
    }
    
    long badgeNumber = [badgeValue longLongValue];
    // 如果文字尺寸大于控件宽度
    if (badgeNumber > 9 && badgeNumber < 100) {
        // 显示中等大小图片
        [self setBackgroundImage:[UIImage imageNamed:@"badge_cart_icon2"]
                        forState:UIControlStateNormal];
    }
    else if (badgeNumber > 99) {
        // 设置文字内容
        [self setTitle:@"99+" forState:UIControlStateNormal];
        // 显示内容和大红点背景
        [self setBackgroundImage:[UIImage imageNamed:@"badge_cart_icon1"]
                        forState:UIControlStateNormal];
        
    } else {
        // 设置图片
        [self setBackgroundImage:[UIImage imageNamed:@"badge_cart_icon3"]
                        forState:UIControlStateNormal];
        
    }
    
    // 尺寸自适应
    [self sizeToFit];
}

@end
