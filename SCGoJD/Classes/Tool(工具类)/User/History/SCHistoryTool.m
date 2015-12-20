//
//  SCHistoryTool.m
//  SCGoJD
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCHistoryTool.h"

#define SCHistoryKey @"HistoryKey"

@implementation SCHistoryTool

+ (void)saveNewHistory:(SCProductInfo *)productInfo {
    if (productInfo == nil) { return; }
    
    // 取出所有历史记录
    NSMutableArray *history = [NSMutableArray arrayWithArray:[self history]];
    if (history.count) {
        for (NSDictionary *productDic in history) {
            SCProductInfo *productObj = [SCProductInfo objectWithKeyValues:productDic]; // 字典转模型
            if ([productObj.skuId isEqualToString:productInfo.skuId]) {
                [history removeObject:productDic];         // 删除原有的相同记录
                break;
            }
        }
    }
    // 添加新的记录
    [history insertObject:productInfo.keyValues atIndex:0];
    // 保存新记录
    [SCUserDefault setObject:history forKey:SCHistoryKey];
}

+ (NSArray *)history {
    NSArray *history = [SCUserDefault arrayForKey:SCHistoryKey];
    if (history == nil) {
        history  = [NSArray array];
    }
    return history;
}

@end
