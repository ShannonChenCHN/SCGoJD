//
//  SCProductListParam.h
//  SCGoJD
//
//  Created by mac on 15/9/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//  按类别搜索商品的请求参数

#import <Foundation/Foundation.h>

@interface SCProductListParam : NSObject

/**
*  类目编号
*/
@property (nonatomic, copy) NSString *catelogyId;
/**
 *  请求数据的页码
 */
@property (nonatomic, copy) NSString *page;
/**
 *  每页显示数
 */
@property (nonatomic, copy) NSString *pageSize;
/**
 *  客户端类型(目前暂时只支持apple)
 */
@property (nonatomic, copy) NSString *client;

@end
