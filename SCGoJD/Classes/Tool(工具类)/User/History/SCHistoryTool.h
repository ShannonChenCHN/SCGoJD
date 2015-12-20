//
//  SCHistoryTool.h
//  SCGoJD
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 mac. All rights reserved.
//  存取历史访问记录中商品信息的工具类

#import <Foundation/Foundation.h>
#import "SCProductInfo.h"

@interface SCHistoryTool : NSObject

/**
 *  保存历史访问记录数据
 *
 *  @param productInfo 要保存到历史访问记录中的商品信息
 */
+ (void)saveNewHistory:(SCProductInfo *)productInfo;

/**
 *  读取历史访问记录数据
 *
 *  @return 历史访问记录中的商品信息(SCProductInfo.keyValues)
 */
+ (NSArray *)history;

@end
