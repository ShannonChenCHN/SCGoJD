//
//  SCProductInfo.h
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//  商品的详细信息模型

#import <Foundation/Foundation.h>

@interface SCProductInfo : NSObject

/**
 *  商品名
 */
@property (nonatomic, copy) NSString *wname;
/**
 *  广告词
 */
@property (nonatomic, copy) NSString *adword;
/**
 *  京东价
 */
@property (nonatomic, copy) NSString *jdPrice;
/**
 *  颜色
 */
@property (nonatomic, copy) NSString *color;
/**
 *  版本/尺寸
 */
@property (nonatomic, copy) NSString *size;
/**
 *  好评率
 */
@property (nonatomic, copy) NSString *good;
/**
 *  评论数
 */
@property (nonatomic, copy) NSString *totalCount;
/**
 *  大图链接
 */
@property (nonatomic, copy) NSString *imgUrlN1;
/**
 *  商品编号skuId(非返回参数)
 */
@property (nonatomic, copy) NSString *skuId;
/**
 *  购物车中该商品的数量(非返回参数)
 */
@property (nonatomic, copy) NSString *buyCount;
/**
 *  是否被关注(非返回参数)imgUrlN5
 */
@property (nonatomic, copy, getter=isFocused) NSString *focused;
/**
 *
 *  修改jdPrice的显示格式
 */
- (void)editJDPriceFormat;

@end
