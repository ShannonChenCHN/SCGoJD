//
//  SCProductMainController.h
//  SCGoJD
//
//  Created by mac on 15/9/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//  商品详细信息页面

#import <UIKit/UIKit.h>

@interface SCProductMainController : UICollectionViewController 

/**
 *  创建并返回一个SCProductMainController对象,需要传入skuId参数进行数据请求
 *
 *  @param skuId 商品编号skuId
 *
 *  @return 一个SCProductMainController对象
 */
- (instancetype)initWithSkuId:(NSString *)skuId;

@end
