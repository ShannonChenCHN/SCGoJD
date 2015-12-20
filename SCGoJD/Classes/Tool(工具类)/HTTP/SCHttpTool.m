//
//  SCHttpTool.m
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCHttpTool.h"

@implementation SCHttpTool

+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id))success
     failure:(void (^)(NSError *))failure
{
    // post请求
    // 1. 创建请求管理者:请求和解析
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];
    
    // 2. 发送post请求
    [requestManager POST:URLString parameters:parameters
                 success:^(AFHTTPRequestOperation *operation, id responseObject) {
                     
                     if (success) {
                         success(responseObject);
                     }
                     
                 }
                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                     if (failure) {
                         failure(error);
                     }
                 }];
}

+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(id))success
                        failure:(void (^)(NSError *))failure {
    
    // 1. 创建http请求管理者
    AFHTTPRequestOperationManager *requestManager = [AFHTTPRequestOperationManager manager];

    // 2. 发送GET请求:创建并运行一个 `AFHTTPRequestOperation`队列
    AFHTTPRequestOperation *operation
    = [requestManager GET:URLString
               parameters:parameters
                  success:^(AFHTTPRequestOperation *operation, id responseObject) { //请求成功时执行这个success block 中的代码
                    
                    if (success) {
                        success(responseObject);
                    }
                    
                    
                } failure:^(AFHTTPRequestOperation *operation, NSError *error) { //请求失败时执行这个failure
                    
                    if (failure) {
                        failure(error);
                    }
                    
                }];
    
    return operation;
}


@end
