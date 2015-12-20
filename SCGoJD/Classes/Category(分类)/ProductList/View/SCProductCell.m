//
//  SCProductCell.m
//  SCGoJD
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCProductCell.h"
#import "UIImageView+WebCache.h"

@interface SCProductCell ()

@property (weak, nonatomic) IBOutlet UIImageView    *icon;
@property (weak, nonatomic) IBOutlet UILabel        *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel        *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel        *feedbackRateLabel;
@property (weak, nonatomic) IBOutlet UILabel        *commentCountLabel;

@end
@implementation SCProductCell

- (void)setProduct:(SCProduct *)product {
    
    _product = product;
    
    // 设置内容
    if (product) {
        
        [self setContentView];
    }

}

- (void)setContentView {
    // 广告图
    [self.icon sd_setImageWithURL:[NSURL URLWithString:_product.imageUrl]
                 placeholderImage:[UIImage imageNamed:@"colorBuyPlaceholder"]];
    // 产品名
    self.titleLabel.text = _product.wareName;
    // 价格
    self.priceLabel.text = _product.jdPrice;
    // 好评率
    self.feedbackRateLabel.text = _product.good;
    // 评论数
    self.commentCountLabel.text = _product.totalCount;
    
}


@end
