//
//  SCProductDetailList.m
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCProductDetailList.h"
#import "SCProductImagePath.h"

@implementation SCProductDetailList

// 协议方法：实现这个方法，就可以把字典中的字典数组转化成模型数组
// 否则，在转成SCProductDetailList模型时，不知道数组中的字典对应哪个模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"imagePaths" : [SCProductImagePath class]};
}

@end
