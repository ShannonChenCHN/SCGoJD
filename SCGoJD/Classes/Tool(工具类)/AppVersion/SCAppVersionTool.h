//
//  SCAppVersionTool.h
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//  存取app版本信息

#import <Foundation/Foundation.h>

@interface SCAppVersionTool : NSObject
/**
 *  之前保存的版本
 *
 *  @return NSString类型的AppVersion
 */
+ (NSString *)savedAppVersion;
/**
 *  保存新版本
 */
+ (void)saveNewAppVersion:(NSString *)version;

@end
