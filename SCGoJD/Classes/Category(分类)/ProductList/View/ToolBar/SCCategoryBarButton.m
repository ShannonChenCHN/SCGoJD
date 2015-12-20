//
//  SCToolBarButton.m
//  SCGoJD
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCategoryBarButton.h"

#define SCToolBarFontSize [UIFont systemFontOfSize:14]

@implementation SCCategoryBarButton

// 重写初始化方法, 配置button的默认属性
// (注意：在调用buttonWithType时，系统自动调用该方法)
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];

    if (self) {
        // 设置文字颜色
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        // 字体
        self.titleLabel.font = SCToolBarFontSize;
        // 点击时图片不闪烁
        self.adjustsImageWhenHighlighted = NO;
    }
    
    return self;
}

// 1. 重写setTitle方法，扩展根据内容自适应尺寸的功能
- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];

    // 尺寸自适应(调整尺寸的关键)
    [self sizeToFit];
}

// 2. 重写setImage方法
- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    
    // 尺寸自适应(调整尺寸的关键)
    [self sizeToFit];
}

// 3. 重写layoutSubviews方法，调整内容位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.imageView) {
        
        // 调换图片和文字的位置
        // 1. 设置title的原点x坐标在最左边
        self.titleLabel.originX = self.imageView.originX;
        
        // 2 .设置image的原点x坐标在title的最右边
        self.imageView.originX = CGRectGetMaxX(self.titleLabel.frame);
    }
    
}

@end
