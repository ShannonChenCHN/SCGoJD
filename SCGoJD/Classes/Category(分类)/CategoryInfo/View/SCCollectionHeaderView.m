//
//  SCCollectionHeaderView.m
//  SCGoJD
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCollectionHeaderView.h"

#define SCCollectionHeaderFont [UIFont systemFontOfSize:13]

@interface SCCollectionHeaderView ()

@property (nonatomic, weak)UILabel *textLabel;
@property (nonatomic, weak)UIImageView *rankingImage;

@end

@implementation SCCollectionHeaderView

- (void)setHeaderTitle:(NSString *)headerTitle {
    
    _headerTitle = headerTitle;
    
    // 设置背景
    UIImage *backgroundImage = [UIImage imageNamed:@"bg_category_header"];
    self.backgroundColor = [UIColor colorWithPatternImage:backgroundImage];
    // 添加文字标签
    self.textLabel.text = headerTitle;
    [_textLabel sizeToFit];
    // 添加图片
    [self addRankingImage];
}


- (UILabel *)textLabel {
    
    if (_textLabel == nil) {
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textAlignment = NSTextAlignmentLeft;
        textLabel.font = SCCollectionHeaderFont;
        //textLabel.textColor = [UIColor grayColor];
        
        [self addSubview:textLabel];
        _textLabel = textLabel;
    }
    
    return _textLabel;
}

- (void)addRankingImage {
    
    UIImageView *rankingImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"category_ranking"]];
    [rankingImage sizeToFit];
    _rankingImage = rankingImage;
    
    [self addSubview:rankingImage];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _textLabel.originX = 20;
    _textLabel.originY = 5;

    _rankingImage.originX = self.frameWidth - _rankingImage.frameWidth - 10;
    _rankingImage.originY = _textLabel.originY;
}

@end
