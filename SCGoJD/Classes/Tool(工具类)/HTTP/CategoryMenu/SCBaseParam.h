//
//  SCBaseParam.h
//  SCGoJD
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 . All rights reserved.
//  系统级别输入参数（基类),一创建对象，就自动给所有属性赋值（method除外）

#import <Foundation/Foundation.h>
#import "MJExtension.h"

@interface SCBaseParam : NSObject <MJKeyValue>

/**
*  API接口名称
*/
@property (nonatomic, copy) NSString *method;
/**
 *  采用OAuth授权方式为必填参数
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  应用的app_key
 */
@property (nonatomic, copy) NSString *app_key;
/**
 *  API协议版本，可选值:2.0
 */
@property (nonatomic, copy) NSString *v;
/**
 *  应用级别输入参数(JSON文件转成的NSString)
 */
@property (nonatomic, copy) NSString *buy_param_json;  // 与参数名字不同！需要修改

/**
 *  创建并返回一个的SCBaseParam对象，其属性(method除外)已被赋值
 *
 *  @return SCBaseParam对象（属性已经被赋值）
 */
+ (instancetype)parameter;

@end
