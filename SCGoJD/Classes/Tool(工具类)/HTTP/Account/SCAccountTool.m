//
//  SCAccountTool.m
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCAccountTool.h"
#import "SCAccount.h"

#import "SCAccountParam.h"
#import "SCHttpTool.h"

#import "MJExtension.h"

#define SCDocumentsPath         [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
#define SCAccountFilePath       [SCDocumentsPath stringByAppendingPathComponent:@"AccountInfo.data"]

#define SCAccessTokenURL    @"https://oauth.jd.com/oauth/token"
#define SCClient_secret     @"1524ffbf66904396b0b1efbadfda6565"
#define SCRedirect_uri      @"http://www.baidu.com"


@implementation SCAccountTool

// 类方法里一般用静态变量代替成员属性,成员变量前要加下划线
// 如果每次都创建一个对象的话，更耗内存
static SCAccount *_account;

// 保存账号信息
+ (void)saveAccount:(SCAccount *)account
{
    [NSKeyedArchiver archiveRootObject:account toFile:SCAccountFilePath];
}

// 读取账号信息
+ (SCAccount *)account
{
    // 注意：没有必要每次访问_account都读取文件, 只在打开程序时读取就OK
    if (_account == nil) {
        
        _account = [NSKeyedUnarchiver unarchiveObjectWithFile:SCAccountFilePath];
        
        // 在打开程序时判断是否过期:当前时间 < 过期时间(上一次授权时保存的)则不过期, 否则过期
        if ([[NSDate date] compare:_account.expires_date] != NSOrderedAscending) {
            return nil;
        }
    }
    SCLog(@"账号:%@", _account.access_token);
    return _account;
}

+ (void)accountWithCode:(NSString *)code
                success:(void (^)())success
                failure:(void (^)(NSError *))failure
{
    
    // 1 设置请求参数：(参考新浪的accessToken官方文档)
    SCAccountParam *postParameters = [[SCAccountParam alloc] init];
    postParameters.client_id = SCClient_id;
    postParameters.client_secret = SCClient_secret;
    postParameters.grant_type = @"authorization_code";
    postParameters.code = code;
    postParameters.redirect_uri = SCRedirect_uri;

    // 2 发送请求 (请求参数模型需要转成字典)
    [SCHttpTool POST:SCAccessTokenURL parameters:[postParameters keyValues]
             success:^(id responseObject) {
                 // 下载plist结果到桌面上
                 [(NSDictionary *)responseObject writeToFile:@"/Users/mac/Desktop/test.xml" atomically:YES];
                 // 获取结果参数:字典转模型
                 SCAccount *account = [SCAccount accountWithDictionary:responseObject];
                 // 保存账号信息
                 // 一般在开发中我们会经常用到业务类,也就是专门用来处理数据的存储读取，
                 // 如果以后我不想归档，想用数据库的话，直接改业务类就OK了
                 [SCAccountTool saveAccount:account];
                 
                 if (success) {
                     success();
                 }
                 
             } failure:^(NSError *error) {
                 
                 if (failure) {
                     failure(error);
                 }
             }];
}

@end
