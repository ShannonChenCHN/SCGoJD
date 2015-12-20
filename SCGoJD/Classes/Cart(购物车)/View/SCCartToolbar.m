//
//  SCCartToolbar.m
//  SCGoJD
//
//  Created by mac on 15/9/30.
//  Copyright (c) 2015年 mac. All rights reserved.
//
/**
 *  工具条包括两个button和一个label:
 *  1. 点击全选按钮时, 全选按钮图片改变, (传入items空数组)表格刷新, 
 *  所有的cell都取消选中状态, 按钮图片改变, 总金额改变, 结算数量改变;
 *  2. cell上的按钮的选中与否决定着总金额和结算数量
 *  3. 当重新将所有的cell选中时, 全选按钮图片自动改变
 *
 */
#import "SCCartToolbar.h"
#import "SCProductToolCommon.h"
#import "SCProductInfo.h"

#define SCToolBarButtonFontSize         [UIFont systemFontOfSize:17]
#define SCToolBarButtonFontSizeSmall    [UIFont systemFontOfSize:14]
#define SCPriceLabelWidth               170

@interface SCCartToolbar ()

@property (nonatomic, weak) UIButton *selectButton;
@property (nonatomic, weak) UIButton *totalPriceView;
@property (nonatomic, weak) UIButton *payButton;

@end

@implementation SCCartToolbar

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubviews];
    }
    return self;
}

- (void)setCellItems:(NSMutableArray *)cellItems {
    _cellItems = cellItems;
    
    // 设置全选状态:初始状态就是全选
    self.selectButton.selected = YES;
    for (NSString *selection in cellItems) {
        if ([selection isEqualToString:SC_NO_string]) {
            self.selectButton.selected = NO;
        }
    }
    
    // 设置总价
    [_totalPriceView setTitle:self.totalPrice forState:UIControlStateNormal];
    // 设置数量:富文本标题
    NSString *payString = [NSString stringWithFormat:@"去结算(%@)", self.buyCount];
    NSMutableAttributedString *payTitle = [[NSMutableAttributedString alloc] initWithString:payString];
    [payTitle addAttribute:NSFontAttributeName
                      value:SCToolBarButtonFontSize
                      range:NSMakeRange(0, payTitle.length)];
    [payTitle addAttribute:NSForegroundColorAttributeName
                      value:[UIColor whiteColor]
                      range:NSMakeRange(0, payTitle.length)];
    [payTitle addAttribute:NSFontAttributeName
                        value:SCToolBarButtonFontSizeSmall
                        range:NSMakeRange(3, payTitle.length - 3)];
    [_payButton setAttributedTitle:payTitle forState:UIControlStateNormal];
    
}

#pragma mark 计算结算商品数量
- (NSString *)buyCount {
    NSArray *products = [SCCartTool cart];
    NSUInteger buycount = 0;
    NSUInteger i = 0;
    for (NSString *selection in self.cellItems) {
        if (selection.boolValue) {
            // 取出模型
            SCProductInfo *productInfo = products[i];
            buycount += productInfo.buyCount.longLongValue;
        }
        i++;
    }
    
    return [NSString stringWithFormat:@"%li", buycount];
}

#pragma mark 计算总金额
- (NSString *)totalPrice {
    NSArray *products = [SCCartTool cart];
    CGFloat totalPrice = 0;
    
    NSUInteger i = 0;
    for (NSString *selection in self.cellItems) {
        if (selection.boolValue) {    // 如果被选中
            // 取出字典转成模型
            SCProductInfo *productInfo = products[i];
            NSString *price = [productInfo.jdPrice substringFromIndex:1];

            totalPrice += price.doubleValue * productInfo.buyCount.longLongValue;
            
        }
        i++;
    }
    
    return [NSString stringWithFormat:@"合计 : ¥ %.2f", totalPrice];
}

#pragma mark - 添加按钮
- (void)addSubviews {
    // 全选按钮
    _selectButton = [self addOneButtonWithTitle:@"全选"
                                      titleFont:SCToolBarButtonFontSizeSmall
                                          image:[UIImage imageNamed:@"flight_butn_check_unselect"]
                                  selectedImage:[UIImage imageNamed:@"flight_butn_check_select"]];
    
    // 总计金额按钮
    _totalPriceView = [self addOneButtonWithTitle:@""
                                        titleFont:SCToolBarButtonFontSize
                                            image:nil
                                    selectedImage:nil];
    
    // 结算按钮
    [self addPayButton];
}
#pragma mark 分别添加左边两个按钮
- (UIButton *)addOneButtonWithTitle:(NSString *)title
                          titleFont:(UIFont *)font
                              image:(UIImage *)image
                      selectedImage:(UIImage *)selectedImage {
    // 创建
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    // 图片
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:selectedImage forState:UIControlStateSelected];
    
    // 背景
    [button setBackgroundImage:[UIImage imageNamed:@"blackBack"]
                      forState:UIControlStateNormal];
    // 文字标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = font;
    // 点击时图片不闪烁
    button.adjustsImageWhenHighlighted = NO;
    // 点击事件
    [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    // 标记
    button.tag = self.subviews.count;
    // 添加
    [self addSubview:button];
    
    return button;
}

#pragma mark 结算按钮
- (void)addPayButton {
    // 创建
    UIButton *payButton = [UIButton buttonWithType:UIButtonTypeCustom];
    // 背景
    [payButton setBackgroundImage:[UIImage imageNamed:@"wandershop_red_buy"]
                         forState:UIControlStateNormal];

    // 点击事件
    [payButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    // 标记
    payButton.tag = self.subviews.count;
    // 引用
    _payButton = payButton;
    [self addSubview:payButton];
}

#pragma mark -点击按钮
- (void)clickButton:(UIButton *)button {
    
    if ([_delegate respondsToSelector:@selector(cartToolBar:didClickButton:)]) {
        [_delegate cartToolBar:self didClickButton:button];
    }
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 全选
    CGFloat selectX = 0;
    CGFloat selectY = 0;
    CGFloat selectWidth = (self.frameWidth - SCPriceLabelWidth) * 0.5;
    CGFloat selectHeight = self.frameHeight;
    _selectButton.Frame = CGRectMake(selectX, selectY, selectWidth, selectHeight);
    // 合计
    CGFloat countX = CGRectGetMaxX(_selectButton.frame);
    CGFloat countY = 0;
    CGFloat countWidth = SCPriceLabelWidth;
    CGFloat countHeight = self.frameHeight;
    _totalPriceView.Frame = CGRectMake(countX, countY, countWidth, countHeight);
    // 结算
    CGFloat payX = CGRectGetMaxX(_totalPriceView.frame);
    CGFloat payY = 0;
    CGFloat payWidth = selectWidth;
    CGFloat payHeight = self.frameHeight;
    _payButton.Frame = CGRectMake(payX, payY, payWidth, payHeight);
}

@end
