//
//  SCHttpTool.h
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//  网络请求工具类

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface SCHttpTool : NSObject


/**
 *  POST请求
 *
 *  @param URLString  用来创建请求URL的URL string(基本URL)
 *  @param parameters 请求参数
 *  @param success    请求成功时回调
 *  @param failure    请求失败时回调
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure;
/**
 *  GET请求
 *
 *  @param URLString  用来创建请求URL的URL string(基本URL)
 *  @param parameters 请求参数
 *  @param success    请求成功时回调
 *  @param failure    请求失败时回调
 */
+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
 parameters:(id)parameters
    success:(void (^)(id responseObject))success
    failure:(void (^)(NSError *error))failure;

@end
