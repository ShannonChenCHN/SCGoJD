//
//  SCCatelogyListResponse.h
//  SCGoJD
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//  返回的最高级分类信息

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface SCCatelogyListResponse : NSObject <MJKeyValue>
/**
 *  最高级分类列表(category)
 */
@property (nonatomic, strong) NSArray *catelogyList;

@end
