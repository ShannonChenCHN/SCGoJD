//
//  SCImageScrollController.h
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 . All rights reserved.
//  商品图片滚动

#import <UIKit/UIKit.h>

@interface SCImageScrollController : UICollectionViewController

/**
 *  当前所在页码
 */
@property (nonatomic, copy) NSString *currentPageNum;

/**
 *  创建并返回一个SCImageScrollController对象, 并配置了cell尺寸和图片内容
 *
 *  @param itemSize cell的大小
 *
 *  @param imagePaths 要显示的图片的URL
 *
 *  @return 一个SCImageScrollController对象
 */
- (instancetype)initWithItemSize:(CGSize)itemSize imagePaths:(NSArray *)imagePaths;

@end
