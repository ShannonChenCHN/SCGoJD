//
//  SCProductCell.h
//  SCGoJD
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCProduct.h"

@interface SCProductCell : UITableViewCell
/**
 *  商品基本信息
 */
@property (nonatomic, strong) SCProduct *product;

@end
