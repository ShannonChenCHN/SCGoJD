//
//  SCCatelogListTool.m
//  SCGoJD
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCatelogListTool.h"

#import "MJExtension.h"

#import "SCBaseParam.h"
#import "SCCatelogListParam.h"
#import "SCCatelogyListResponse.h"

#define SCApiMethod     @"jingdong.ware.product.catelogy.list.get"

@implementation SCCatelogListTool

+ (AFHTTPRequestOperation *)GETCatelogyListWithLevel:(NSString *)level
                      catelogyId:(NSString *)catelogyId
                         success:(void (^)(NSArray *))success
                         failure:(void (^)(NSError *))failure {
    
    // 应用级参数
    SCCatelogListParam *catelogListParam = [[SCCatelogListParam alloc] init];
    catelogListParam.level = level;
    catelogListParam.catelogyId = catelogyId;
    
    // 系统级参数
    SCBaseParam *baseParam = [SCBaseParam parameter];
    baseParam.method = SCApiMethod;
    baseParam.buy_param_json = catelogListParam.JSONString;  // 模型转JSON字符串

    
    // 发送GET请求:创建并运行一个 `AFHTTPRequestOperation`队列
    AFHTTPRequestOperation *operation
    = [SCHttpTool GET:SCApiBaseURL parameters:baseParam.keyValues success:^(id responseObject) { //请求成功时执行这个success block 中的代码

        NSDictionary *dic1 = responseObject[@"jingdong_ware_product_catelogy_list_get_responce"];
        NSDictionary *dic2 = dic1[@"productCatelogyList"];
        // 字典转模型
        SCCatelogyListResponse *catelogyList = [SCCatelogyListResponse objectWithKeyValues:dic2];
        
        if (success) {
            success(catelogyList.catelogyList);
        }
        
    } failure:^(NSError *error) { //请求失败时执行这个failure
        
        if (failure) {
            failure(error);
        }
    }];
    
    return operation;
}

@end
