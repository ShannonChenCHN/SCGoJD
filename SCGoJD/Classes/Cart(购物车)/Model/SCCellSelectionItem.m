//
//  SCCellSelectionItem.m
//  SCGoJD
//
//  Created by mac on 15/10/7.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCellSelectionItem.h"
#import "SCCartTool.h"

@implementation SCCellSelectionItem

#pragma mark 同时设置所有cell的item的选中状态为YES
+ (NSMutableArray *)selectAllCellItems {
    
   return [self setAllItems:SC_YES_string];
}


#pragma mark 同时设置所有cell的item的选中状态为NO
+ (NSMutableArray *)deselectAllCellItems {
    
    return [self setAllItems:SC_NO_string];
}


#pragma mark 同时设置所有cell的item的选中状态
+ (NSMutableArray *)setAllItems:(NSString *)isSelected {
    
    NSMutableArray *array = [NSMutableArray array];
    for (NSUInteger i = 0; i < self.products.count; i++) {
        [array addObject:isSelected];
    }
    return array;
}

#pragma mark 取出购物车所有商品
+ (NSMutableArray *)products {
    NSMutableArray *products = [SCCartTool cart];
    return products;
}

@end
