//
//  SCFocusTool.m
//  SCGoJD
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCFocusTool.h"

#define SCFocusKey @"FocusKey"

@implementation SCFocusTool

+ (void)focusProduct:(SCProductInfo *)productInfo {
    if (productInfo == nil) { return; }
    
    // 移除已经关注的相同产品, 取出更新后的所有正在关注的商品
    NSMutableArray *focuses = [self removeFocusedProductWithskuId:productInfo.skuId];

    // 添加新的关注
    productInfo.focused = SC_YES_string;
    [focuses insertObject:productInfo.keyValues atIndex:0];

    // 保存新记录
    [SCUserDefault setObject:focuses forKey:SCFocusKey];
    NSLog(@"关注%@", focuses);
}

+ (NSMutableArray *)removeFocusedProductWithskuId:(NSString *)skuId {
    
    // 取出所有正在关注的商品
    NSMutableArray *focuses = [NSMutableArray arrayWithArray:[self focuses]];
    if (focuses.count && skuId) {
        for (NSDictionary *productDic in focuses) {
            SCProductInfo *productObj = [SCProductInfo objectWithKeyValues:productDic]; // 字典转模型
            
            if ([productObj.skuId isEqualToString:skuId]) {
                [focuses removeObject:productDic];     // 移除指定商品
                [SCUserDefault setObject:focuses forKey:SCFocusKey]; // 保存更改
                break;
            }
        }
    }
    
    return focuses;
}

+ (NSArray *)focuses {
    NSArray *focuses = [SCUserDefault arrayForKey:SCFocusKey];
    if (focuses == nil) {
        focuses = [NSArray array];
    }
    return focuses;
}

+ (NSString *)hasFocusedProductWithSkuId:(NSString *)skuId {
    NSString *focus = @"";
    NSArray *focuses = [SCFocusTool focuses];
    for (NSDictionary *product in focuses) {
        SCProductInfo *productInfo = [SCProductInfo objectWithKeyValues:product]; // 字典转模型
        if ([skuId isEqualToString:productInfo.skuId]) {
            focus = SC_YES_string;
        }
    }

    
    return focus;
}

@end
