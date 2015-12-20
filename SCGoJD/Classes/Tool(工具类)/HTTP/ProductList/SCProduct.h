//
//  SCProduct.h
//  SCGoJD
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//  商品信息模型(搜索结果)

#import <Foundation/Foundation.h>

@interface SCProduct : NSObject

/**
*  广告词
*/
@property (nonatomic, copy) NSString *adWord;
/**
 *  图片url
 */
@property (nonatomic, copy) NSString *imageUrl;
/**
 *  是否是图书
 */
@property (nonatomic, assign) BOOL isBook;
/**
 *  京东价
 */
@property (nonatomic, copy) NSString *jdPrice;
/**
 *  市场价
 */
@property (nonatomic, copy) NSString *martPrice;
/**
 *  商品sku编号,用来获取产品可选颜色、尺寸
 */
@property (nonatomic, copy) NSString *skuId;
/**
 *  商品名
 */
@property (nonatomic, copy) NSString *wareName;
/**
 *  好评率
 */
@property (nonatomic, copy) NSString *good;
/**
 *  评论数
 */
@property (nonatomic, copy) NSString *totalCount;


@end
