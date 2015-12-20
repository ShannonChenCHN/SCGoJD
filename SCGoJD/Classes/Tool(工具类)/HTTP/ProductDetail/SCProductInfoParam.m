//
//  SCProductInfoParam.m
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCProductInfoParam.h"

#define SCIsLoadWareScore   @"true"
#define SCClient            @"apple"

@implementation SCProductInfoParam

- (void)setSkuId:(NSString *)skuId {
    
    _skuId = skuId;
    
    _isLoadWareScore = SCIsLoadWareScore;
    _client = SCClient;
}

@end
