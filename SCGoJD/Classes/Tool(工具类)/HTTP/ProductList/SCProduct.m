//
//  SCProduct.m
//  SCGoJD
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCProduct.h"

@implementation SCProduct

- (void)setSkuId:(NSString *)skuId {
    
    skuId = [skuId stringByReplacingOccurrencesOfString:@"," withString:@""];
    _skuId = skuId;
    
    // 设置好评率
    CGFloat good = [_skuId longLongValue] / ([_skuId longLongValue] + 100000.0);
    _good = [NSString stringWithFormat:@"好评%.0f%%", good * 100];
    // 设置评论数
    _totalCount = [NSString stringWithFormat:@"%@人", [_skuId substringToIndex:5]];
}

- (NSString *)jdPrice {
    
    if ([_jdPrice containsString:@"."]) {
        _jdPrice = [NSString stringWithFormat:@"￥%@0", _jdPrice];
    } else {
        _jdPrice = [NSString stringWithFormat:@"￥%@.00", _jdPrice];
    }
    return _jdPrice;
}

- (NSString *)imageUrl {
    
    return [_imageUrl stringByReplacingOccurrencesOfString:@"/n5/" withString:@"/n0/"];
}


@end
