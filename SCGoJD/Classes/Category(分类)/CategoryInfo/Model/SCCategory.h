//
//  SCCategory.h
//  SCGoJD
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//  最高级分类目录

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface SCCategory : NSObject <MJKeyValue>
/**
 *  类别代号
 */
@property (nonatomic, copy) NSString *cid;
/**
 *  具体描述
 */
@property (nonatomic, copy) NSString *detail_description;
/**
 *  所属父类
 */
@property (nonatomic, assign) int fid;
/**
 *  图标URL
 */
@property (nonatomic, copy) NSString *icon;
/**
 *  当前类的级别
 */
@property (nonatomic, assign) int level;
/**
 *  类别名
 */
@property (nonatomic, copy) NSString *name;

@end
