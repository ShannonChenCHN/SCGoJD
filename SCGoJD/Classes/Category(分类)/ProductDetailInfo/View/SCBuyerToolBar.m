//
//  SCBuyerToolBar.m
//  SCGoJD
//
//  Created by mac on 15/9/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//


/*
    1.  视图一加载, 就读取收藏夹和购物车的文件, 传入参数isFavorite, productsInCart给buyerToolBar显示,
    2.  点击加入购物车, 首先[通知]主控制器将SCProductTableController的text属性的值读取出来(用代理), 
        然后再结合本地存储的数量, 重新计算购物车中商品总数量, 并保存到本地,同时重新给buyerToolBar传入
        items参数, 因为toolBarbutton设置了KVO方式来监听items中badgeValue的变化, 所以toolBarbutton
        中会自动改变badgeView的数值;
    3.  点击关注按钮时, 首先判断当前的isFavorite属性的值, 如果是, 就取消♥️,改标题, 同时从本地文件中移除记录,反之亦然。
 image, title, badgeValue
 */

#import "SCBuyerToolBar.h"
#import "SCProductToolCommon.h"
#import "SCDetailBarButton.h"

#import "SCMyProductItem.h"

#define SCPutInCartFontSize     [UIFont systemFontOfSize:19]
#define SCBuyButtonPercentage   0.45

@interface SCBuyerToolBar ()

@property (nonatomic, weak) SCDetailBarButton *focusButton;
@property (nonatomic, weak) SCDetailBarButton *cartButton;
@property (nonatomic, weak) UIButton *buyButton;

@end

@implementation SCBuyerToolBar

#pragma mark - 懒加载
- (UIButton *)focusButton {
    if (_focusButton == nil) {
        _focusButton = [self addOneButtonWithTag:self.subviews.count];
    }
    return _focusButton;
}

- (UIButton *)cartButton {
    if (_cartButton == nil) {
        _cartButton = [self addOneButtonWithTag:self.subviews.count];
    }
    return _cartButton;
}

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addBuyButton];    // 一初始化就添加
    }
    return self;
}

- (instancetype)init {
    
    CGFloat X = 0;
    CGFloat Y = 0;
    CGFloat width = SCMainScreenBounds.size.width;
    CGFloat height = SCBuyerToolBarHeight;
    
    return [self initWithFrame:CGRectMake(X, Y, width, height)];
}

#pragma mark - 重写set方法
- (void)setItem:(SCMyProductItem *)item {
    _item = item;

    // 有数据才加载左边两个button
    self.focusButton.item = item;
    self.cartButton.item = item;
    
}

#pragma mark - 添加按钮
#pragma mark - 分别添加左边的按钮
- (SCDetailBarButton *)addOneButtonWithTag:(NSUInteger)tag {
    
    SCDetailBarButton *button = [SCDetailBarButton buttonWithTag:tag];

    [button addTarget:self
               action:@selector(clickButton:)
     forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:button];
    
    return button;
}

#pragma mark 加入购物车按钮
- (UIButton *)addBuyButton {
    // 创建UIButton
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置属性
    [buyButton setBackgroundImage:[UIImage imageNamed:@"wandershop_red_buy"]
                         forState:UIControlStateNormal];
    [buyButton setTitle:@"加入购物车" forState:UIControlStateNormal];
    buyButton.titleLabel.font = SCPutInCartFontSize;
    [buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    //点击事件
    [buyButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    
    // 设置tag
    buyButton.tag = self.subviews.count;
    
    // 引用
    _buyButton = buyButton;
    [self addSubview:buyButton];
    
    return buyButton;
}

#pragma mark - <CategoryListToolBarDelegate>
- (void)clickButton:(UIButton *)button {
    
    if ([_delegate respondsToSelector:@selector(toolBar:didClickButtonAtIndex:)]) {

        [_delegate toolBar:self didClickButtonAtIndex:button.tag];
    }
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    NSUInteger count = self.subviews.count;
    CGFloat y = 0;
    CGFloat height = self.frameHeight;
    
    CGFloat x = 0;
    CGFloat width = 0;
    
    for (int i = 0; i < count; i++) {
        if (i == 0) {
            width = SCMainScreenBounds.size.width * SCBuyButtonPercentage;
            x = SCMainScreenBounds.size.width - width;
        } else {
            width = SCMainScreenBounds.size.width * (1 - SCBuyButtonPercentage) * 0.5;
            x = width * (i - 1);
        }
        
        [self.subviews[i] setFrame:CGRectMake(x, y, width, height)];
    }
}

@end
