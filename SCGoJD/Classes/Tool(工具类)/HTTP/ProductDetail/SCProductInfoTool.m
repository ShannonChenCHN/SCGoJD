//
//  SCProductInfoTool.m
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCProductInfoTool.h"
#import "MJExtension.h"

#import "SCBaseParam.h"
#import "SCProductInfoParam.h"

#define SCApiMethod     @"jingdong.ware.product.detail.search.list.get"

@implementation SCProductInfoTool

+ (AFHTTPRequestOperation *)GETProductInfoWithSkuId:(NSString *)skuId
                                            success:(void (^)(SCProductDetailList *))success
                                            failure:(void (^)(NSError *))failure {

    // 应用级参数
    SCProductInfoParam *productInfoParam = [[SCProductInfoParam alloc] init];
    productInfoParam.skuId = skuId;
    
    // 系统级参数
    SCBaseParam *baseParam = [SCBaseParam parameter];
    baseParam.method = SCApiMethod;
    baseParam.buy_param_json = productInfoParam.JSONString;  // 模型转JSON字符串
    
    // 发送GET请求:创建并运行一个 `AFHTTPRequestOperation`队列
    AFHTTPRequestOperation *operation
    = [SCHttpTool GET:SCApiBaseURL parameters:baseParam.keyValues success:^(id responseObject) {

        NSDictionary *dic1 = responseObject[@"jingdong_ware_product_detail_search_list_get_responce"];
        NSDictionary *dic2 = dic1[@"productDetailList"];
        SCProductDetailList *productDetailList = [SCProductDetailList objectWithKeyValues:dic2];

        if (success) {
            success(productDetailList);
        }
        
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    return operation;
}

@end
