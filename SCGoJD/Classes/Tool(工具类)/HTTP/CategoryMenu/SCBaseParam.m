//
//  SCBaseParam.m
//  SCGoJD
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCBaseParam.h"

#import "SCAccountTool.h"
#import "SCAccount.h"

#define SC_API_Protocol_Version @"2.0"

@implementation SCBaseParam

// 解决属性名与服务器参数key不一致的问题
+ (NSDictionary *)replacedKeyFromPropertyName {
    
    // key是属性名, value是参数名
    return @{@"buy_param_json" : @"360buy_param_json"};
}

// 一旦子类调用该类方法创建对象，就会自动给属性access_token赋值
+ (instancetype)parameter
{
    SCBaseParam *baseParam = [[self alloc] init]; // 注意：这里是基类,必须用self, 而不能用SCBaseParam,要考虑子类
    // 设置基本参数
    baseParam.access_token = [SCAccountTool account].access_token;
    baseParam.app_key = SCClient_id;
    baseParam.v = SC_API_Protocol_Version;
    
    return baseParam;
}


@end
