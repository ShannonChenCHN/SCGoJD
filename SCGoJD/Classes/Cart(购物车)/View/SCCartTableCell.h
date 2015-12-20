//
//  SCCartTableCell.h
//  SCGoJD
//
//  Created by mac on 15/9/30.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCProductInfo.h"

@class SCCartTableCell;

@protocol SCCartTableCellDelegate <NSObject>

@optional
- (void)tableViewCell:(SCCartTableCell *)cell
          atIndexPath:(NSIndexPath *)indexPath
didClickButtonAtIndex:(NSInteger)index;

@end

@interface SCCartTableCell : UITableViewCell


@property (nonatomic, weak) id <SCCartTableCellDelegate> delegate;
/**
 *  商品详细信息
 */
@property (nonatomic, strong) SCProductInfo *productInfo;
/**
 *  创建自定义的SCCartTableCell对象，同时tableView可重用该cell
 *
 *  @param tableView 重用SCCartTableCell对象的tableView
 *
 *  @return SCCartTableCell对象
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;
/**
 *  传入所有cell的被选中状态和cell的位置
 *
 *  @param cellItems 购物车中商品的被选中状态(NSString:@"YES"/@"NO")
 *  @param indexPath cell的位置
 */
- (void)setCellItems:(NSMutableArray *)cellItems forIndexPath:(NSIndexPath *)indexPath;

@end
