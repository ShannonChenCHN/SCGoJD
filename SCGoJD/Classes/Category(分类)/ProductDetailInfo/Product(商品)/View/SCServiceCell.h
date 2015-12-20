//
//  SCServiceCell.h
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//  显示当前所选商品服务信息的cell

#import <UIKit/UIKit.h>
#import "SCCommonCell.h"

@interface SCServiceCell : SCCommonCell

/**
 *  商品的详细信息模型
 */
@property (nonatomic, strong) SCProductInfo *productInfo;

@end
