//
//  SCTitleView.m
//  SCGoJD
//
//  Created by mac on 15/9/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCTitleView.h"
#import "SCProductMainController.h"

@interface SCTitleView ()

// 记住选中的按钮
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation SCTitleView

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addButtons];
        // 监听页面滚动位置
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectedButton:) name:SCCurrentPageDidChangeNotification object:nil];

        [self clickButton:self.subviews[0]];  //默认选中第0个
    }
    
    return self;
}

- (instancetype)init {
    
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat width = SCMainScreenBounds.size.width / 3;
    CGFloat height = 44;
    CGRect frame = CGRectMake(originX, originY, width, height);
    
    return [self initWithFrame:frame];
}

#pragma mark - 添加所有按钮
- (void)addButtons {
    
    [self addButtonWithTitle:@"商品" target:self action:@selector(clickButton:)];
    
    [self addButtonWithTitle:@"详情" target:self action:@selector(clickButton:)];
    
    [self addButtonWithTitle:@"评论" target:self action:@selector(clickButton:)];
}

// 添加一个按钮
- (void)addButtonWithTitle:(NSString *)title
                    target:(id)target
                    action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 设置字体
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    // 设置选中时的backgroundImage
    [button setBackgroundImage:[UIImage imageNamed:@"bg_navi_button"] forState:UIControlStateSelected];
    button.adjustsImageWhenHighlighted = NO;
    
    //点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置tag
    button.tag = self.subviews.count;
    
    [self addSubview:button];
}
#pragma mark - 监听页面滚动位置
- (void)changeSelectedButton:(NSNotification *)notification {

    NSUInteger currentPageNumber = [notification.object longLongValue];
    [self clickButton:self.subviews[currentPageNumber]];
}

#pragma mark - <SCTitleViewDelegate>
- (void)clickButton:(UIButton *)button {
    //取消原来的选中按钮
    _selectedButton.selected = NO;
    _selectedButton.titleLabel.font = [UIFont systemFontOfSize:13];   // 改变字体大小
    // 设置新的选中按钮
    button.selected = YES;
    _selectedButton = button;
    button.titleLabel.font = [UIFont systemFontOfSize:16];  // 改变字体大小
   
    if ([_delegate respondsToSelector:@selector(titleView:didClickButtonAtIndex:)]) {

        [_delegate titleView:self didClickButtonAtIndex:button.tag];
    }
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    NSUInteger count = self.subviews.count;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat width = self.frameWidth / count;
    CGFloat height = self.frameHeight;
    
    for (int i = 0; i < count; i++) {
        x = width * i;
        
        [self.subviews[i] setFrame:CGRectMake(x, y, width, height)];
    }
}

#pragma mark - 移除通知观察者
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
