//
//  SCCommentCell.m
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCommentCell.h"

@interface SCCommentCell ()
@property (weak, nonatomic) IBOutlet UILabel *goodPercentage;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;

@end

@implementation SCCommentCell

- (void)setProductInfo:(SCProductInfo *)productInfo {
    [super setProductInfo:productInfo];
    
    // 好评率
    _goodPercentage.text = productInfo.good;
    
    // 评论数
    NSString *count = @"";
    if (productInfo.totalCount) {
        count = [NSString stringWithString:productInfo.totalCount];
        count = [count stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    _commentCount.text =  [count stringByAppendingString:@"人评论"];
}


@end
