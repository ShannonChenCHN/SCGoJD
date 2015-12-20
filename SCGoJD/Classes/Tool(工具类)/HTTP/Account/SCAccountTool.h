//
//  SCAccountTool.h
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//  专门处理账号的业务类（获取账号信息accessToken以及账号的存取）

#import <Foundation/Foundation.h>
#import "SCAccount.h"

@interface SCAccountTool : NSObject

/**
 *  保存账号信息(归档)
 *
 *  @param account 一个遵守NSCoding协议的SCAccount对象
 */
+ (void)saveAccount:(SCAccount *)account;

/**
 *  读取账号信息(解档)
 *
 *  @return 一个遵守NSCoding协议的SCAccount对象
 */
+ (SCAccount *)account;
/**
 *  获取accessToken并保存至preference
 *
 *  @param code    调用authorize获得的code值
 *  @param success 获取accessToken成功时回调的block
 *  @param failure 获取accessToken失败时回调的block
 */
+ (void)accountWithCode:(NSString *)code
                success:(void (^)())success
                failure:(void (^)(NSError *error))failure;

@end
