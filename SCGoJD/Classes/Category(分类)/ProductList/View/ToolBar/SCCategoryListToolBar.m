//
//  SCCategoryListToolBar.m
//  SCGoJD
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCategoryListToolBar.h"
#import "SCCategoryCommon.h"
#import "SCCategoryBarButton.h"

@implementation SCCategoryListToolBar

#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.image = [UIImage stretchableImageNamed:@"bg_white_toolBar"];
        self.userInteractionEnabled = YES;
        [self addButtons];
    }
    
    return self;
}

- (instancetype)init {
    
    CGFloat originX = 0;
    CGFloat width = SCMainScreenBounds.size.width;
    CGFloat height = 35;
    CGFloat originY = 44 + SCStatusBarHeight - 3;
    CGRect frame = CGRectMake(originX, originY, width, height);
    
    return [self initWithFrame:frame];
}

#pragma mark - 添加所有按钮
- (void)addButtons {
    
    [self addButtonWithTitle:@"综合"
                 normalImage:[UIImage imageNamed:@"category_downTap"]
               selectedImage:[UIImage imageNamed:@"category_upTap"]
                      target:self
                      action:@selector(clickButton:)];
    
    [self addButtonWithTitle:@"销量"
                 normalImage:nil
               selectedImage:nil
                      target:self
                      action:@selector(clickButton:)];
    
    [self addButtonWithTitle:@"价格"
                 normalImage:[UIImage imageNamed:@"up"]
               selectedImage:[UIImage imageNamed:@"flight_arrow_mini_up"]
                      target:self
                      action:@selector(clickButton:)];
    
    [self addButtonWithTitle:@"筛选"
                 normalImage:[UIImage imageNamed:@"flight_b_tab_filter_icon_inactive"]
               selectedImage:[UIImage imageNamed:@"flight_b_tab_filter_icon_inactive"]
                      target:self
                      action:@selector(clickButton:)];
    

}

// 添加一个按钮
- (void)addButtonWithTitle:(NSString *)title
              normalImage:(UIImage *)normalImage
             selectedImage:(UIImage *)selectedImage
                    target:(id)target
                    action:(SEL)action {
    SCCategoryBarButton *button = [SCCategoryBarButton buttonWithType:UIButtonTypeCustom];
    // 设置标题
    [button setTitle:title forState:UIControlStateNormal];
    
    // 设置image而不是backgroundImage，否则图片会被拉伸
    if (normalImage) {
        [button setImage:normalImage forState:UIControlStateNormal];
    }
    if (selectedImage) {
        [button setImage:selectedImage forState:UIControlStateSelected];
    }
    
    //点击事件
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 设置tag
    button.tag = self.subviews.count;
    
    [self addSubview:button];
}

#pragma mark - <CategoryListToolBarDelegate>
- (void)clickButton:(UIButton *)button {
    // 切换选中状态 ,以切换图片显示
    button.selected = !button.selected;
    if (button.tag != 0) {
    }
    
    if ([_delegate respondsToSelector:@selector(categoryListToolBar:didClickButtonAtIndex:)]) {
        
        [_delegate categoryListToolBar:self didClickButtonAtIndex:button.tag];
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

@end
