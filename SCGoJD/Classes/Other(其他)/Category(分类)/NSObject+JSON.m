//
//  NSObject+JSON.m
//  SCGoJD
//
//  Created by mac on 15/9/23.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "NSObject+JSON.h"
#import "MJExtension.h"

@implementation NSObject (JSON)

- (NSString *)JSONString {
    
    NSData *JSONData = nil;
    if ([self isKindOfClass:[NSDictionary class]]) { // 如果self是NSDictionary
        
        JSONData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
    } else if ([self isKindOfClass:[NSObject class]]) {        // 如果self是继承NSObject的非字典对象
     
        JSONData = [NSJSONSerialization dataWithJSONObject:self.keyValues options:NSJSONWritingPrettyPrinted error:nil];
    }
    
    return [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
}

@end
