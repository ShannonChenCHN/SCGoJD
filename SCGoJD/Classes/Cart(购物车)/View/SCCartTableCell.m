//
//  SCCartTableCell.m
//  SCGoJD
//
//  Created by mac on 15/9/30.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCartTableCell.h"
#import "UIImageView+WebCache.h"

@interface SCCartTableCell ()

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSMutableArray *cellItems;

@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextField *countTextField;

- (IBAction)select:(id)sender;
- (IBAction)subtract:(id)sender;
- (IBAction)plus:(id)sender;

@end

@implementation SCCartTableCell

#pragma mark - 工厂方法：创建cell，给tableView重用
+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *reuseIdentifier = @"reuseIdentifier";
    id cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SCCartTableCell" owner:nil options:nil] lastObject];
    }
    
    return cell;
}

- (void)setCellItems:(NSMutableArray *)cellItems forIndexPath:(NSIndexPath *)indexPath {
    _cellItems = cellItems;
    _indexPath = indexPath;
    if ([cellItems[indexPath.row] isEqualToString:SC_YES_string]) {
        [_selectButton setImage:[UIImage imageNamed:@"flight_butn_check_select"]
                       forState:UIControlStateNormal];
    } else {
        [_selectButton setImage:[UIImage imageNamed:@"flight_butn_check_unselect"]
                       forState:UIControlStateNormal];
    }
}

- (void)setProductInfo:(SCProductInfo *)productInfo {
    _productInfo = productInfo;
    
    // 设置内容
    if (productInfo) {
        
        [self setContentView];
    }
    
}

- (void)setContentView {
    // 配图
    [_icon sd_setImageWithURL:[NSURL URLWithString:_productInfo.imgUrlN1]
             placeholderImage:[UIImage imageNamed:@"colorBuyPlaceholder"]];
    
    // 商品名
    _nameLabel.text = _productInfo.wname;
    // 价格
    _priceLabel.text = _productInfo.jdPrice;

    // 数量
    _countTextField.text = _productInfo.buyCount;
}

- (void)clickButton:(UIButton *)button {
    if ([_delegate respondsToSelector:@selector(tableViewCell:atIndexPath:didClickButtonAtIndex:)]) {
        [_delegate tableViewCell:self atIndexPath:_indexPath didClickButtonAtIndex:button.tag];
    }
}

- (IBAction)select:(id)sender {
    [self clickButton:sender];
}

- (IBAction)subtract:(id)sender {
    long long text = [_countTextField.text longLongValue] - 1;
    if (text == 0) return;
    _countTextField.text = [NSString stringWithFormat:@"%lli", text];
    
    [self clickButton:sender];
}

- (IBAction)plus:(id)sender {
    long long text = [_countTextField.text longLongValue] + 1;
    _countTextField.text = [NSString stringWithFormat:@"%lli", text];
    
    [self clickButton:sender];
}

@end
