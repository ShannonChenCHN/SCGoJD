//
//  SCProductImagePath.h
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//   商品详细信息配图URL

#import <Foundation/Foundation.h>

@interface SCProductImagePath : NSObject

/**
 *  大图URL
 */
@property (nonatomic, copy) NSString *bigpath;
/**
 *  小图URL
 */
@property (nonatomic, copy) NSString *newpath;

@end
