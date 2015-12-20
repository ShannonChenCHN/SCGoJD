//
//  SCImageCell.m
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCImageCell.h"
#import "SCImageScrollController.h"

#define SCPageNumFontSize   [UIFont systemFontOfSize:18]

#define SCPageNumberDidChangeNotification  @"SCPageNumberDidChange"

@interface SCImageCell ()


// 商品配图URL(NSString)
@property (nonatomic, strong) NSArray *imagePaths;
@property (nonatomic, assign) CGRect realBounds;
@property (nonatomic, strong) SCImageScrollController *imageScrollVC;
@property (nonatomic, weak) UIButton *badgeView;

@end

@implementation SCImageCell

#pragma mark - 懒加载
- (SCImageScrollController *)imageScrollVC {
    if (_imageScrollVC == nil) {
        CGSize size = CGSizeMake(SCMainScreenBounds.size.width, 350);
        _imageScrollVC
        = [[SCImageScrollController alloc] initWithItemSize:_realBounds.size
                                                 imagePaths:self.imagePaths];
        _imageScrollVC.view.frame = self.bounds;
        [self.contentView addSubview:_imageScrollVC.view];
    }
    
    return _imageScrollVC;
}

- (UIButton *)badgeView {
    if (_badgeView == nil) {
        UIButton *badgeView = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [badgeView setBackgroundImage:[UIImage imageNamed:@"newbarcode_button_normal"] forState:UIControlStateNormal];
        badgeView.titleLabel.font = SCPageNumFontSize;
        [badgeView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [badgeView sizeToFit];      // 尺寸大小
        badgeView.enabled = NO;     // 不允许点击
        
        _badgeView = badgeView;
        [self.contentView addSubview:badgeView];
    }
    return _badgeView;
}

#pragma mark - 重写set方法:不要重复添加子控件
- (void)setImagePaths:(NSArray *)imagePaths cellHeight:(CGFloat)cellHeight {
    
    [super setImagePaths:imagePaths cellHeight:cellHeight];
    _imagePaths = imagePaths;
    
    // 1. 设置realbounds
    _realBounds = CGRectMake(0, 0, SCMainScreenBounds.size.width, cellHeight);
    // 2. 设置内容
    if (imagePaths) {
        // 先添加滚动图片（同时添加观察者）
        [self imageScrollVC];
        
        // 后添加页码
        [self configBadgeView];
    }
    
    // 监听页面滚动位置
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCurrentPageNumber:) name:SCPageNumberDidChangeNotification object:nil];
}

#pragma mark - 设置页码badgeView的内容
- (void)configBadgeView {
    NSUInteger num = [_imageScrollVC.currentPageNum longLongValue] + 1;
    NSString *pageNum = [NSString stringWithFormat:@"%lu/%lu", num, _imagePaths.count];
    if (!_imagePaths.count) {
        pageNum = @"0/0";
    }
    [self.badgeView setTitle:pageNum forState:UIControlStateNormal];
    [_badgeView sizeToFit];
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat margin = 10;
    CGFloat X = self.contentView.frameWidth - _badgeView.frameWidth - margin;
    CGFloat Y = self.contentView.frameHeight - _badgeView.frameHeight - margin;
    _badgeView.originX = X;
    _badgeView.originY = Y;
    
}

#pragma mark - 监听页面滚动位置
- (void)changeCurrentPageNumber:(NSNotification *)notification {
    
    [self configBadgeView];
}

#pragma mark - 移除通知观察者
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
