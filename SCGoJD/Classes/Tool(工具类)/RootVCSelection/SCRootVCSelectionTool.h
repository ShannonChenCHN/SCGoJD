//
//  SCRootVCSelectionTool.h
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//  选择根控制器

#import <Foundation/Foundation.h>

@interface SCRootVCSelectionTool : NSObject

/**
 *   根据是否授权设置根控制器
 */
+ (void)setRootViewControllerForWindow:(UIWindow *)window;

@end
