//
//  SCCellSelectionItem.h
//  SCGoJD
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 mac. All rights reserved.
//  记录所有cell的选中状态

#import <Foundation/Foundation.h>

@interface SCCellSelectionItem : NSObject

/**
 *  全选：同时设置所有cell的item的选中状态为YES
 *
 *  @return 所有cell的item的选中状态
 */
+ (NSMutableArray *)selectAllCellItems;

/**
 *  全不选：同时设置所有cell的item的选中状态为NO
 *
 *  @return 所有cell的item的选中状态
 */
+ (NSMutableArray *)deselectAllCellItems;

@end
