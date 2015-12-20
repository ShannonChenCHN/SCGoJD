//
//  SCDetailCategoryCell.m
//  SCGoJD
//
//  Created by mac on 15/9/24.
//  Copyright (c) 2015年 mac. All rights reserved.
//  详细分类的图标

#import "SCDetailCategoryCell.h"
#import "UIImageView+WebCache.h"

#define SCCategoryCellTextSize [UIFont systemFontOfSize:11]

@interface SCDetailCategoryCell ()

@property (nonatomic, weak) UIImageView *imageView;
@property (nonatomic, weak) UILabel *textLabel;

@end

@implementation SCDetailCategoryCell

- (void)setCategory:(SCCategory *)category {
    
    _category = category;
    
    // 添加图片
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:category.icon]
                      placeholderImage:[UIImage imageNamed:@"jdm_photo_placeholer"]];
    
    // 添加文字
    self.textLabel.text = category.name;
}

#pragma mark - 懒加载
- (UIImageView *)imageView {
    if (_imageView == nil) {
        // 注意：这里不需要设置frame，子控件的frame都在layoutSubviews中设置
        UIImageView *tempImageView = [[UIImageView alloc] init];
        
        _imageView = tempImageView;
        
        // 注意：一定要加载到contentView上，如果加载到view上则有可能被遮住
        [self.contentView addSubview:tempImageView];
    }
    
    return _imageView;
}

- (UILabel *)textLabel {
    if (_textLabel == nil) {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.backgroundColor = [UIColor whiteColor];
        textLabel.font = SCCategoryCellTextSize;
        textLabel.textAlignment = NSTextAlignmentCenter;
        
        _textLabel = textLabel;
        [self.contentView addSubview:textLabel];
    }
    
    return _textLabel;
}

#pragma mark - 布局子控件
- (void)layoutSubviews {
    [super layoutSubviews];
    
    SCLog(@"图:%@", _category.icon);
    // 图片
    CGFloat margin = 10;
    _imageView.frameWidth = self.frameWidth - 2 * margin;
    _imageView.frameHeight = self.frameHeight * 0.8;
    _imageView.centerX = self.frameWidth / 2;
    _imageView.centerY = _imageView.frameHeight * 0.5;

    
    // 文字
    _textLabel.originX = 0;
    _textLabel.originY = _imageView.frameHeight;
    _textLabel.frameWidth = self.frameWidth;
    _textLabel.frameHeight = self.frameHeight - _textLabel.originY;
    
}

@end
