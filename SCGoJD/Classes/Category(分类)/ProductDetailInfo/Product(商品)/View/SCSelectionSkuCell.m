//
//  SCSelectionSkuCell.m
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCSelectionSkuCell.h"

@interface SCSelectionSkuCell ()

@property (weak, nonatomic) IBOutlet UILabel *selectionInfoLabel;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;
- (IBAction)plusButton:(id)sender;
- (IBAction)subtractButton:(id)sender;


@end

@implementation SCSelectionSkuCell

#pragma mark - 重写set方法
- (void)setProductInfo:(SCProductInfo *)productInfo {
    [super setProductInfo:productInfo];
    
    // 设置内容
    if (productInfo) {
        
        [self setContentView];
    }
    
}

- (void)setContentView {
    
    // 颜色
    NSString *selectionString = [NSString stringWithString:self.productInfo.color];
    if (selectionString.length && self.productInfo.size.length) {
        
        selectionString = [selectionString stringByAppendingString:@"、"];
    }
    // 版本
    selectionString = [selectionString stringByAppendingString:self.productInfo.size];
    _selectionInfoLabel.text = selectionString;
    // 数量
    _countTextField.text = @"1";
    _countTextField.keyboardType = UIKeyboardTypeNumberPad;
    [_countTextField addTarget:self action:@selector(textFieldDidChangeCharacters) forControlEvents:UIControlEventEditingChanged];
}

#pragma mark - 点击加减按钮
- (IBAction)plusButton:(id)sender {
    NSInteger count = [_countTextField.text longLongValue] + 1;
    
    _countTextField.text = [NSString stringWithFormat:@"%li", count];
    
    [self postNotification];
}

- (IBAction)subtractButton:(id)sender {
    NSInteger count = [_countTextField.text longLongValue];
    if (count > 1) {
        count--;
    }
    _countTextField.text = [NSString stringWithFormat:@"%li", count];
    
    [self postNotification];
}

#pragma mark - 输入框内容改变时调用
- (void)textFieldDidChangeCharacters {
    [self postNotification];
}

#pragma mark 改变数量时发出通知
- (void)postNotification {

    [[NSNotificationCenter defaultCenter] postNotificationName:SCSelectedProductCountDidChangeNotification object:_countTextField.text];
}


@end
