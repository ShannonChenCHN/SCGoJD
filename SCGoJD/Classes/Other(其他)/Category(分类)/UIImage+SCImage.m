//
//  UIImage+SCImage.m
//  SCGoJD
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//  

#import "UIImage+SCImage.h"

@implementation UIImage (SCImage)

+ (instancetype)originalImageNamed:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)stretchableImageNamed:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5
                                      topCapHeight:image.size.height * 0.5];
}

@end
