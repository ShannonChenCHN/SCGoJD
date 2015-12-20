//
//  SCProductInfo.m
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCProductInfo.h"
#import "SCFocusTool.h"

@implementation SCProductInfo

- (void)editJDPriceFormat {

    NSRange range = [_jdPrice rangeOfString:@"."];
    if (range.length > 0) {
        NSString *str = [_jdPrice substringFromIndex:range.location]; // 截取小数部分
        
        if (str.length == 3) {                      // 补充最后的一位0
            _jdPrice = [NSString stringWithFormat:@"%@0", _jdPrice];
        }
        
    } else {                                        // 补充小数部分
        _jdPrice = [NSString stringWithFormat:@"%@.00", _jdPrice];
        
    }
    _jdPrice = [NSString stringWithFormat:@"￥%@", _jdPrice];
}

@end
