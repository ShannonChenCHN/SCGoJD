//
//  SCCatelogListParam.m
//  SCGoJD
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCatelogListParam.h"

#define SCClient        @"apple"
#define SCParamBOOL     @"true"

@implementation SCCatelogListParam

- (void)setLevel:(NSString *)level {
    
    _level = level;
    
    // 设置其他默认属性
    _isIcon = SCParamBOOL;
    _isDescription = SCParamBOOL;
    _client = SCClient;
}

@end
