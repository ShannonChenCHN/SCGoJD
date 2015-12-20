//
//  SCProductListTool.m
//  SCGoJD
//
//  Created by mac on 15/9/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCProductListTool.h"
#import "MJExtension.h"

#import "SCBaseParam.h"
#import "SCProductListParam.h"
#import "SCSearchCatelogyList.h"

#define SCApiMethod     @"jingdong.ware.promotion.search.catelogy.list"

@implementation SCProductListTool

+ (AFHTTPRequestOperation *)GETProductListWithcatelogyId:(NSString *)catelogyId
                                                    page:(NSString *)page
                                                 success:(void (^)(NSArray *))success
                                                 failure:(void (^)(NSError *))failure {
    
    // 应用级参数
    SCProductListParam *productListParam = [[SCProductListParam alloc] init];
    productListParam.catelogyId = catelogyId;
    productListParam.page = page;
    
    // 系统级参数
    SCBaseParam *baseParam = [SCBaseParam parameter];
    baseParam.method = SCApiMethod;
    baseParam.buy_param_json = productListParam.JSONString;  // 模型转JSON字符串
    
    // 发送GET请求:创建并运行一个 `AFHTTPRequestOperation`队列
    AFHTTPRequestOperation *operation
    = [SCHttpTool GET:SCApiBaseURL parameters:baseParam.keyValues success:^(id responseObject) {
        
        NSDictionary *dic1 = responseObject[@"jingdong_ware_promotion_search_catelogy_list_responce"];
        NSDictionary *dic2 = dic1[@"searchCatelogyList"];
        SCSearchCatelogyList *list = [SCSearchCatelogyList objectWithKeyValues:dic2];
        if (success) {
            success(list.wareInfo);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return operation;
}

@end
