//
//  SCSearchCatelogyList.m
//  SCGoJD
//
//  Created by mac on 15/9/25.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCSearchCatelogyList.h"
#import "SCProduct.h"

@implementation SCSearchCatelogyList

// 协议方法：实现这个方法，就可以把字典中的字典数组转化成模型数组
// 否则，在转成SCProduct模型时，不知道数组中的字典对应哪个模型
+ (NSDictionary *)objectClassInArray
{
    return @{@"wareInfo" : [SCProduct class]};
}

@end
