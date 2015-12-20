//
//  SCProductMainCell.m
//  SCGoJD
//
//  Created by mac on 15/9/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//  

#import "SCProductMainCell.h"

@interface SCProductMainCell ()

@end

@implementation SCProductMainCell

-(void)setContentSubview:(UIView *)contentSubview {
    if (_contentSubview) {
        [_contentSubview removeFromSuperview];   // 移除之前的内容视图
    }
    _contentSubview = contentSubview;
    [self.contentView addSubview:contentSubview];
}

@end
