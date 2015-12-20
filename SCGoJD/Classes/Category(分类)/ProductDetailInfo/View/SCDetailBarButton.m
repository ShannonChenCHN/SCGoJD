//
//  SCSCDetailBarButton.m
//  SCGoJD
//
//  Created by mac on 15/9/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCDetailBarButton.h"
#import "SCBadgeView.h"

#define SCImageRidio                0.7
#define SCItemKeyPathFocused        @"focused"
#define SCItemKeyPathProductCount   @"productCount"

@interface SCDetailBarButton ()

@property (nonatomic, weak) SCBadgeView *badgeView;
// 记录上一次的数据
@property (nonatomic, copy) NSString *isFocused;
@property (nonatomic, copy) NSString *badgeValue;

@end

@implementation SCDetailBarButton

// 懒加载badgeView (一调用getter方法就执行以下代码, 私有属性无需setter方法)
- (SCBadgeView *)badgeView {
    if (_badgeView == nil) {
        SCBadgeView *badgeView = [SCBadgeView buttonWithType:UIButtonTypeCustom];
        [self addSubview:badgeView];
        
        _badgeView = badgeView;
    }
    
    return _badgeView;
}

#pragma mark - 工厂方法
+ (instancetype)buttonWithTag:(NSUInteger)tag {
    SCDetailBarButton *button = [self buttonWithType:UIButtonTypeCustom];
    
    if (button) {
        // tag
        button.tag = tag;
        // 设置字体颜色
        [button setTitleColor:[UIColor whiteColor]
                   forState:UIControlStateNormal];
        // 设置背景
        [button setBackgroundImage:[UIImage imageNamed:@"blackBack"]
                        forState:UIControlStateNormal];
        // 图片居中
        button.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
        button.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        if (button.tag == 2) {
            [button setImage:[UIImage imageNamed:@"detailBar_cart_press"] forState:UIControlStateHighlighted];
        }
        button.adjustsImageWhenHighlighted = NO;
    }
    
    return button;
}

#pragma mark - 传递UITabBarItem给tabBarButton,给tabBarButton的属性赋值(关键点)
#pragma mark 1. setter方法：接收UITabBarItem传入的参数item
- (void)setItem:(SCMyProductItem *)item {
    //设值
    _item = item;
    
    // 注意：第一次没有变化时，手动调用该方法，根据item设置显示初始内容
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    // KVO:时刻监听一个对象的属性有没有改变
    // 观察对象:传入的item(SCMyProductItem)
    // Observer:按钮
    [item addObserver:self
           forKeyPath:SCItemKeyPathFocused
              options:NSKeyValueObservingOptionNew
              context:nil];
    [item addObserver:self
           forKeyPath:SCItemKeyPathProductCount
              options:NSKeyValueObservingOptionNew
              context:nil];
}

#pragma mark 只要监听的item的属性一有新值，就会调用该方法重新给属性赋值
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {

    if (self.tag == 1) {
        // 记录改变前的数据
        _isFocused = self.titleLabel.text;

        if ([_item.isFocused isEqualToString:SC_YES_string]) {
            
            [self setImage:[UIImage imageNamed:@"wareb_focus_end"] forState:UIControlStateNormal];
            [self setTitle:@"已关注" forState:UIControlStateNormal];
            
            if ([_isFocused isEqualToString:@"关注"]) {         //  数据改变才有动画
                [self startImageViewAnimationForChange:change];
            }
            
        } else {
            [self setImage:[UIImage imageNamed:@"wareb_focus"] forState:UIControlStateNormal];
            [self setTitle:@"关注" forState:UIControlStateNormal];
            
        }
        
    } else if (self.tag == 2) {
        // 记录改变前的数据
        _badgeValue = self.badgeView.badgeValue;
        
        [self setImage:[UIImage imageNamed:@"detailBar_cart_normal"] forState:UIControlStateNormal];
        [self setTitle:@"购物车" forState:UIControlStateNormal];
        self.badgeView.badgeValue = _item.productCount;
        
        if ([_badgeValue isEqualToString:_item.productCount] == NO) {  // 数值改变才有动画
            [self startBadgeViewAnimationForChange:change];
        }
        
    }
    
}

#pragma mark - 动画
- (void)startImageViewAnimationForChange:(NSDictionary *)change {
    
    if (change) {                   // 第一次不出现动画
        [UIView animateWithDuration:0.1 animations:^{
            self.imageView.transform = CGAffineTransformMakeScale(1.2, 1.2);
        } completion:^(BOOL finished) {
            // 停1秒再还原
            [UIView animateWithDuration:0.1 delay:1 options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 // 还原
                                 self.imageView.transform = CGAffineTransformIdentity;
                                 
                             } completion:nil];
        }];
    }
}

- (void)startBadgeViewAnimationForChange:(NSDictionary *)change {
    
    if (change) {                   // 第一次不出现动画
        [UIView animateWithDuration:0.1 animations:^{
            self.badgeView.transform = CGAffineTransformMakeScale(1.3, 1.3);
        } completion:^(BOOL finished) {
            // 停1秒再还原
            [UIView animateWithDuration:0.1 delay:1 options:UIViewAnimationOptionCurveLinear
                             animations:^{
                                 // 还原
                                 self.badgeView.transform = CGAffineTransformIdentity;
                                 
                             } completion:nil];
        }];
    }
}

#pragma mark - 设置按钮子控件的位置和大小
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 1. imageView(充满控件区域)
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageWidth = self.bounds.size.width;
    CGFloat imageHeight = self.bounds.size.height * SCImageRidio; //  0.7倍高度
    self.imageView.frame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
    
    // 2. title
    CGFloat titleX = 0;
    CGFloat titleY = imageHeight - 3;           // 底部边缘往上3个单位
    CGFloat titleWidth = self.bounds.size.width;
    CGFloat titleHeight = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleWidth, titleHeight);
    
    // 3. badgeView
    self.badgeView.originX = self.frameWidth * 0.5 + 6;
    self.badgeView.originY = 5;
    
}

#pragma mark - 移除观察者
- (void)dealloc {
    
    [_item removeObserver:self forKeyPath:SCItemKeyPathFocused];
    [_item removeObserver:self forKeyPath:SCItemKeyPathProductCount];
}

@end
