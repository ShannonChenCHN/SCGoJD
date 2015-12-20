//
//  SCSearchCatelogyList.h
//  SCGoJD
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//  按类别搜索商品的返回参数

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface SCSearchCatelogyList : NSObject <MJKeyValue>

/**
 *  商品信息(SCProduct)
 */
@property (nonatomic, strong) NSArray *wareInfo;
/**
 *  结果数据所属页码
 */
@property (nonatomic, copy) NSString *page;
/**
 *  符合要求的商品总数
 */
@property (nonatomic, copy) NSString *wareCount;

@end
