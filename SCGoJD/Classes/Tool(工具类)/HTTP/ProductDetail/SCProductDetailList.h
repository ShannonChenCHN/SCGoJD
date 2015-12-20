//
//  SCProductDetailList.h
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//  商品详细信息数据列表模型(含SCProductInfo)

#import <Foundation/Foundation.h>
#import "MJExtension.h"

#import "SCProductInfo.h"

@interface SCProductDetailList : NSObject   <MJKeyValue>

/**
 *  商品配图URL(SCProductImagePath)
 */
@property (nonatomic, strong) NSArray *imagePaths;
/**
 *  商品详细信息
 */
@property (nonatomic, strong) SCProductInfo *productInfo;

@end
