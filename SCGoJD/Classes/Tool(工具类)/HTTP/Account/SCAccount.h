//
//  SCAccount.h
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//  账户信息模型

#import <Foundation/Foundation.h>

@interface SCAccount : NSObject

/**
 *  获取数据的访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  有效期内的刷新令牌
 */
@property (nonatomic, copy) NSString *refresh_token;
/**
 *  账号的有效期(从当前时间算起,单位：秒)
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  授权用户对应的京东ID
 */
@property (nonatomic, copy) NSString *uid;
/**
 *  账号过期的时间
 */
@property (nonatomic, strong) NSDate *expires_date;
/**
 *  授权用户对应的京东昵称
 */
@property (nonatomic, copy) NSString *user_nick;


/**
 *  用字典转模型的方式来创建并初始化一个Account对象
 *
 *  @param dictionary 一个NSDictionary对象，其中的键值对与Account对象的属性一一对应
 *
 *  @return 存有dictionary中的数据的Account对象
 */
+ (instancetype)accountWithDictionary:(NSDictionary *)dictionary;

@end
