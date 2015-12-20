//
//  SCNewFeatureCell.m
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCNewFeatureCell.h"

#import "SCRootVCSelectionTool.h"

@interface SCNewFeatureCell ()

@property (nonatomic, weak) UIButton *startButton;

@end

@implementation SCNewFeatureCell

- (UIButton *)startButton {
    
    if (_startButton == nil) {
        
        UIButton *tempStartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        // 设置图片
        [tempStartButton setImage:[UIImage imageNamed:@"functionGuideBt1"]
                                   forState:UIControlStateNormal];
        [tempStartButton setImage:[UIImage imageNamed:@"functionGuideBt2"]
                                   forState:UIControlStateHighlighted];
        
        // 尺寸自适应
        [tempStartButton sizeToFit];
        
        // 添加点击事件
        [tempStartButton addTarget:self
                            action:@selector(startJD:)
                  forControlEvents:UIControlEventTouchUpInside];
        
        
        [self addSubview:tempStartButton];
        
        _startButton = tempStartButton;
    }
    
    return _startButton;
}

#pragma mark - 获取当前页码和最后一页的页码,判断是否显示按钮
- (void)setCurrentPageIndex:(NSInteger)currentIndex lastPageIndex:(NSInteger)lastIndex {
    
    if (currentIndex == lastIndex) { // 如果是最后一页就显示button
        
        self.startButton.hidden = NO;
        
    } else {
        
        self.startButton.hidden = YES;
    }
}

#pragma mark  - 点击开始按钮时调用
- (void)startJD:(UIButton *)button {
   
    // 根据授权与否选择窗口根控制器
    [SCRootVCSelectionTool setRootViewControllerForWindow:SCKeyWindow];
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置开始按钮中心
    self.startButton.center = CGPointMake(self.frameWidth * 0.5, self.frameHeight * 0.9);

}

@end
