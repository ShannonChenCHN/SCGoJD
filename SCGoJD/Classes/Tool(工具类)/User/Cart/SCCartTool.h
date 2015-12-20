//
//  SCCartTool.h
//  SCGoJD
//
//  Created by mac on 15/9/29.
//  Copyright (c) 2015年 mac. All rights reserved.
//  存取购物车中商品信息的工具类

#import <Foundation/Foundation.h>
#import "SCProductInfo.h"

@interface SCCartTool : NSObject

/**
 *  添加商品至购物车: 保存购物车数据, 不论是不是重复购买, 都会将新数据排在数组的第一位
 *
 *  @param productInfo  要保存到购物车中的商品信息
 *  @param count        要购买该商品的数量
 *
 */
+ (void)buyProduct:(SCProductInfo *)productInfo count:(NSString *)count;
/**
 *  重复添加商品至购物车: 保存购物车数据, 用新数据替换原数据, 在数组中的位置不发生变化
 *
 *  @param productInfo  要保存到购物车中的商品信息
 *  @param count        要购买该商品的数量
 *
 */
+ (void)buyMoreProduct:(SCProductInfo *)productInfo count:(NSString *)count;
/**
 *  读取购物车数据
 *
 *  @return 购物车中的商品信息(SCProductInfo)
 */
+ (NSMutableArray *)cart;
/**
 *  读取购物车中购买总量
 *
 *  @return 购买总量
 */
+ (NSString *)totalCount;
/**
 *  删除购物车中的商品
 *
 */
+ (void)removeProductWithSkuId:(NSString *)skuId;

@end
