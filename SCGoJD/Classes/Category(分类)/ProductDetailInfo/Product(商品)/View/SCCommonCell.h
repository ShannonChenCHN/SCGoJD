//
//  SCCommonCell.h
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//  基类

/**
 *  注意:子类中不能直接访问父类的成员变量, 要用self.访问
 */

#import <UIKit/UIKit.h>
#import "SCProductInfo.h"

@interface SCCommonCell : UITableViewCell

/**
 *  商品的详细信息模型
 */
@property (nonatomic, strong) SCProductInfo *productInfo;

/**
 *  设置cell要显示的图片URL和真实高度
 *
 *  @param imagePaths 商品配图URL(NSString)
 *
 *  @param  cellHeight cell的真实高度
 */
- (void)setImagePaths:(NSArray *)imagePaths cellHeight:(CGFloat)cellHeight;

@end
