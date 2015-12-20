//
//  SCProductInfoTool.h
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//  请求商品详细信息的工具类

#import <Foundation/Foundation.h>
#import "SCHttpTool.h"

#import "SCProductDetailList.h"

@interface SCProductInfoTool : NSObject

/**
 *  根据商品编号skuId请求商品详细信息数据
 *
 *  @param skuId 第三级类目
 *  @param success    请求成功时调用
 *  @param failure    请求失败时调用
 *
 *  @return 发出请求的队列
 */
+ (AFHTTPRequestOperation *)GETProductInfoWithSkuId:(NSString *)skuId
                                            success:(void (^)(SCProductDetailList *productInfoList))success
                                            failure:(void (^)(NSError *error))failure;

@end
