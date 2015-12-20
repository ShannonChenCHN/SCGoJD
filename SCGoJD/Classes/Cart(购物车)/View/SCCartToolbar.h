//
//  SCCartToolbar.h
//  SCGoJD
//
//  Created by mac on 15/9/30.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCCartToolbarDelegate <NSObject>

@optional
- (void)cartToolBar:(UIView *)toolBar didClickButton:(UIButton *)button;

@end



@interface SCCartToolbar : UIView

/**
 *  购物车中商品的被选中状态(NSString:@"YES"/@"NO")
 */
@property (nonatomic, strong) NSMutableArray *cellItems;
@property (nonatomic, weak) id <SCCartToolbarDelegate> delegate;

@end
