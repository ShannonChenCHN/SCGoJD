//
//  SCCartEditToolBar.h
//  SCGoJD
//
//  Created by mac on 15/10/6.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SCCartEditToolbarDelegate <NSObject>

@optional
- (void)cartToolBar:(UIView *)toolBar didClickButton:(UIButton *)button;

@end

@interface SCCartEditToolBar : UIView

/**
 *  购物车中商品的被选中状态(NSString:@"YES"/@"NO")
 */
@property (nonatomic, strong) NSMutableArray *cellItems;

@property (nonatomic, weak) id <SCCartEditToolbarDelegate> delegate;

@end
