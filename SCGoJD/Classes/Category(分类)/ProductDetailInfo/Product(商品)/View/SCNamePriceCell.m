//
//  SCNamePriceCell.m
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCNamePriceCell.h"

@interface SCNamePriceCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *adWordsLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *noteLabel;


@end

@implementation SCNamePriceCell

- (void)setProductInfo:(SCProductInfo *)productInfo {
    [super setProductInfo:productInfo];
    
    // 设置内容
    if (productInfo) {
        
        [self setContentView];
    }
    
}

- (void)setContentView {
    // 产品名
    _nameLabel.text = self.productInfo.wname;
    // 广告词
    _adWordsLabel.text = self.productInfo.adword;
    
    // 价格
    self.priceLabel.text = self.productInfo.jdPrice;
    
    // 降价通知
    _noteLabel.enabled = NO;
}


@end
