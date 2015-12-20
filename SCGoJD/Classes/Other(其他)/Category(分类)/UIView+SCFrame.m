//
//  UIView+SCFrame.m
//  SCGoJD
//
//  Created by mac on 15/9/21.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "UIView+SCFrame.h"

@implementation UIView (SCFrame)


#pragma mark - 实现setter、getter方法
#pragma mark 原点X
// 设值
- (void)setOriginX:(CGFloat)originX {
    
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
}
// 取值
- (CGFloat)originX {
    
    return self.frame.origin.x;
}

#pragma mark 原点Y
// 设值
- (void)setOriginY:(CGFloat)originY {
    
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
}

// 取值
- (CGFloat)originY {
    
    return self.frame.origin.y;
}

#pragma mark 宽width
// 设值
- (void)setFrameWidth:(CGFloat)frameWidth {
    
    CGRect frame = self.frame;
    frame.size.width = frameWidth;
    self.frame = frame;
}

// 取值
- (CGFloat)frameWidth {
    
    return self.frame.size.width;
}

#pragma mark 高height
// 设值
- (void)setFrameHeight:(CGFloat)frameHeight {
    
    CGRect frame = self.frame;
    frame.size.height = frameHeight;
    self.frame = frame;
}

// 取值
- (CGFloat)frameHeight {
    
    return self.frame.size.height;
}

#pragma mark - center的X
// 设值
- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
// 取值
- (CGFloat)centerX {
    
    return self.center.x;
}

#pragma mark center的Y
// 设值
- (void)setCenterY:(CGFloat)centerY {
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

// 取值
- (CGFloat)centerY {
    
    return self.center.y;
}


@end
