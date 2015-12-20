//
//  SCMyProductItem.h
//  SCGoJD
//
//  Created by mac on 15/9/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//  反映顾客与商品关系的数据模型

#import <Foundation/Foundation.h>

@interface SCMyProductItem : NSObject

/**
 *  是否收藏该商品
 */
@property (nonatomic, copy, getter=isFocused) NSString *focused;
/**
 *  购物车商品总数
 */
@property (nonatomic, assign) NSString *productCount;

@end
