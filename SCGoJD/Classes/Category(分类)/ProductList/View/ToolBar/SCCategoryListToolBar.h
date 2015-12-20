//
//  SCCategoryListToolBar.h
//  SCGoJD
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//  导航条下方的工具条

#import <UIKit/UIKit.h>

@class SCCategoryListToolBar;

@protocol SCCategoryListToolBarDelegate <NSObject>

@optional

- (void)categoryListToolBar:(SCCategoryListToolBar *)toolBar didClickButtonAtIndex:(NSUInteger)index;

@end

@interface SCCategoryListToolBar : UIImageView

@property (nonatomic, weak) id <SCCategoryListToolBarDelegate> delegate;

@end
