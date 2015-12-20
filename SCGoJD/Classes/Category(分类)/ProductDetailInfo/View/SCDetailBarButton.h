//
//  SCDetailBarButton.h
//  SCGoJD
//
//  Created by mac on 15/9/27.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SCMyProductItem.h"

@interface SCDetailBarButton : UIButton

/**
 *   反映顾客与商品关系的数据模型
 */
@property (nonatomic, strong) SCMyProductItem *item;

/**
 *  创建并返回一个SCDetailBarButton对象,需要传入tag参数进行标签设置
 *
 *  @param tag button的标签编号
 *
 *  @return 一个SCDetailBarButton对象
 */
+ (instancetype)buttonWithTag:(NSUInteger)tag;

@end
