//
//  SCCartTool.m
//  SCGoJD
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCartTool.h"

#define SCCartKey @"CartKey"
#define SCCartCountKey @"TotalCountKey"

@implementation SCCartTool

static NSString *_totalCount;

+ (void)buyProduct:(SCProductInfo *)productInfo count:(NSString *)count {
    if (productInfo == nil) return;
    // 重新计算总量
    [self calculateTotalCountWithNewCount:count];
    
    // 取出所有已经购买的商品
    NSMutableArray *products = [NSMutableArray arrayWithArray:[SCUserDefault arrayForKey:SCCartKey]];
    if (products.count) {
        for (NSDictionary *productDic in products) {
            SCProductInfo *productObj = [SCProductInfo objectWithKeyValues:productDic]; // 字典转模型
            if ([productObj.skuId isEqualToString:productInfo.skuId]) {
                count = [NSString stringWithFormat:@"%lli", count.longLongValue + productObj.buyCount.longLongValue];      // 重新计算数量
                [products removeObject:productDic];    // 删除原有的相同记录
                break;
            }
        }
    }
    // 添加新的记录
    productInfo.buyCount = count;
    [products insertObject:productInfo.keyValues atIndex:0];

    [SCUserDefault setObject:products forKey:SCCartKey];
}

+ (void)buyMoreProduct:(SCProductInfo *)productInfo count:(NSString *)count {
    if (productInfo == nil) return;
    // 重新计算总量
    [self calculateTotalCountWithNewCount:count];
    
    // 取出所有已经购买的商品
    NSMutableArray *products = [NSMutableArray arrayWithArray:[SCUserDefault arrayForKey:SCCartKey]];
    if (!products.count) {
        productInfo.buyCount = count;
        [products insertObject:productInfo.keyValues atIndex:0];
        
    } else {
        NSUInteger i = 0;
        for (NSDictionary *productDic in products) {
            SCProductInfo *productObj = [SCProductInfo objectWithKeyValues:productDic]; // 字典转模型
            if ([productObj.skuId isEqualToString:productInfo.skuId]) {
                count = [NSString stringWithFormat:@"%lli", count.longLongValue + productObj.buyCount.longLongValue];      // 重新计算数量

                if ([count isEqualToString:@"0"]) return;
                // 添加新的记录
                productInfo.buyCount = count;
                [products replaceObjectAtIndex:i withObject:productInfo.keyValues];
                break;
            }
            i++;
        }
    }
    
    [SCUserDefault setObject:products forKey:SCCartKey];
}

+ (void)removeProductWithSkuId:(NSString *)skuId {
    // 取出所有已经购买的商品
    NSMutableArray *products = [NSMutableArray arrayWithArray:[SCUserDefault arrayForKey:SCCartKey]];
    for (NSDictionary *productDic in products) {
        SCProductInfo *productObj = [SCProductInfo objectWithKeyValues:productDic]; // 字典转模型
        if ([productObj.skuId isEqualToString:skuId]) {
            
            NSString *removeCount = [NSString stringWithFormat:@"-%@", productObj.buyCount];
            [self calculateTotalCountWithNewCount:removeCount];
            
            [products removeObject:productDic];    // 删除原有的相同记录
            break;
        }
    }
    
    [SCUserDefault setObject:products forKey:SCCartKey];
}

+ (NSMutableArray *)cart {
    NSMutableArray *cart = [NSMutableArray array];
    
    // 取出所有字典
    NSArray *products = [SCUserDefault arrayForKey:SCCartKey];
    if (!products) return cart;
    // 字典转模型
    for (NSDictionary *productDic in products) {
        SCProductInfo *productObj = [SCProductInfo objectWithKeyValues:productDic];
        [cart addObject:productObj];
    }
    return cart;
}

+ (NSString *)totalCount {
    _totalCount = [SCUserDefault stringForKey:SCCartCountKey];
    if (_totalCount == nil) {
        _totalCount = @"0";
    }
    return _totalCount;
}

+ (void)calculateTotalCountWithNewCount:(NSString *)count {
    
    NSUInteger totalCount = count.longLongValue + _totalCount.longLongValue;
    _totalCount = [NSString stringWithFormat:@"%li", totalCount];
    [SCUserDefault setObject:_totalCount forKey:SCCartCountKey];
}

@end
