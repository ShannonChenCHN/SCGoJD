//
//  SCProductInfoParam.h
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//  请求商品详细信息的参数

#import <Foundation/Foundation.h>

@interface SCProductInfoParam : NSObject

/**
*  商品编号skuId
*/
@property (nonatomic, copy) NSString *skuId;
/**
 *  是否加载评分
 */
@property (nonatomic, copy) NSString *isLoadWareScore;
/**
 *  客户端类型(目前暂时只支持apple)
 */
@property (nonatomic, copy) NSString *client;

@end
