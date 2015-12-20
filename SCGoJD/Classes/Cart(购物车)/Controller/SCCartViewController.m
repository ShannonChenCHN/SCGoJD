//
//  SCCartViewController.m
//  SCGoJD
//
//  Created by mac on 15/9/20.
//  Copyright (c) 2015年 mac. All rights reserved.
//
/**
 *  1. 点击全选按钮, cell全部选中或不选中, 结算总金额改变, 结算数量改变;
 *  2. 点击cell, 切换cell的选中和不选中状态, 结算总金额改变, 结算数量改变;
 *  3. 点击cell上的加减按钮, 修改购物车数据, 刷新表格, 修改tabBar显示的数量, 结算总金额改变, 结算数量改变;
 */

#import "SCCartViewController.h"
#import "SCProductToolCommon.h"
#import "SCCartTableCell.h"
#import "SCCartToolbar.h"
#import "SCCartEditToolBar.h"

#import "SCProductMainController.h"

#import "SCCellSelectionItem.h"
#import "SCProductInfo.h"

#import "MJRefresh.h"


@interface SCCartViewController ()  <SCCartToolbarDelegate, SCCartTableCellDelegate,
                                    SCCartEditToolbarDelegate, UIAlertViewDelegate>

// 工具条
@property (nonatomic, weak) SCCartToolbar *toolBar;
@property (nonatomic, weak) SCCartEditToolBar *editToolBar;
// 购物车中的商品信息
@property (nonatomic, strong) NSMutableArray *products;
// 购物车中商品的被选中状态(NSString:@"YES"/@"NO")
@property (nonatomic, strong) NSMutableArray *cellItems;
// 是否处于全选状态
@property (nonatomic, assign, getter=isAllSelected) BOOL selectAll;
// 是否正在编辑购物车
@property (nonatomic, assign) BOOL isEditing;

@end

@implementation SCCartViewController

#pragma mark - 懒加载
- (NSMutableArray *)products {
    if (_products == nil) {
        _products = [SCCartTool cart];
        
    }
    return _products;
}

- (NSMutableArray *)cellItems {
    if (_cellItems == nil) {
        // 初始时为全部选中状态
        _cellItems = [SCCellSelectionItem selectAllCellItems];
    }
    return _cellItems;
}

- (SCCartEditToolBar *)editToolBar {
    if (_editToolBar == nil) {
        SCCartEditToolBar *editToolBar = [[[NSBundle mainBundle] loadNibNamed:@"SCCartEditToolBar" owner:nil options:nil] lastObject];
        editToolBar.delegate = self;
        [self.toolBar addSubview:editToolBar];
        _editToolBar = editToolBar;
    }
    return _editToolBar;
}

#pragma mark - 设置cell的全选状态
- (void)setSelectAll:(BOOL)selectAll {
    _selectAll = selectAll;
    
    if (selectAll) {            // 如果全部选中
        _cellItems = [SCCellSelectionItem selectAllCellItems];
    } else {                    // 如果全部不选中
        _cellItems = [SCCellSelectionItem deselectAllCellItems];
    }
}

- (void)setIsEditing:(BOOL)isEditing {
    _isEditing = isEditing;
    if (isEditing == YES) {
        self.editToolBar.hidden = NO;
    } else {
        self.editToolBar.hidden = YES;
    }
}

#pragma mark - 初始化
- (instancetype)init {
    return [self initWithStyle:UITableViewStylePlain];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置tableView
    self.tableView.tableFooterView = [[UIView alloc] init];    //不显示空的cell
    // 设置导航条按钮
    [self configRightBarButtonItemWithTitle:@"编辑"];
    // 添加下拉刷新
    [self.tableView addHeaderWithTarget:self action:@selector(reloadData:fromFile:)];
    // 自动启动下拉刷新
    [self.tableView headerBeginRefreshing];
    
    // 初始时为全部选中状态
    self.selectAll = YES;
    self.isEditing = NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 添加工具条
    if (_toolBar == nil) {
        [self addToolBar];
    }
    // 刷新当前页面数据
    [self reloadData:YES fromFile:YES];
}

#pragma mark - 刷新前页面数据
- (void)reloadData:(BOOL)reload fromFile:(BOOL)fromFile {
    // 重新读取文件
    if (fromFile == YES) {
        _products = nil;    // 相当于self.products = [SCCartTool cart];
        _cellItems = nil;
        [self postNotificationToTabBarVC];  // 发送通知
    }
    // 刷新表格
    [self.tableView reloadData];
    
    // 刷新工具条
    if (self.isEditing) {
        self.editToolBar.cellItems = self.cellItems;
    } else {
        self.toolBar.cellItems = self.cellItems;
    }
    
    // 停止下拉刷新
    [self.tableView headerEndRefreshing];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 修改tableView的frame
    self.tableView.frame = CGRectMake(self.tableView.originX,
                                      self.tableView.originY,
                                      self.tableView.frameWidth,
                                      self.tableView.frameHeight - SCBuyerToolBarHeight);
}

#pragma mark - 添加工具条
- (void)addToolBar {
    
    CGFloat width = self.tableView.frameWidth;
    CGFloat height = SCBuyerToolBarHeight;
    CGFloat X = 0;
    CGFloat Y = self.tableView.superview.frameHeight - height - self.tabBarController.tabBar.frameHeight;
    
    // 添加工具条
    SCCartToolbar *toolBar = [[SCCartToolbar alloc] init];
    toolBar.frame = CGRectMake(X, Y, width, height);
    toolBar.delegate = self;
    toolBar.cellItems = self.cellItems;
    
    _toolBar = toolBar;
    [self.tableView.superview insertSubview:toolBar aboveSubview:self.tableView];
}

// 设置右侧按钮
- (void)configRightBarButtonItemWithTitle:(NSString *)title {
    
    self.navigationItem.rightBarButtonItem
    = [[UIBarButtonItem alloc] initWithTitle:title
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(editMyCart:)];
    
}

#pragma mark - 编辑购物车
- (void)editMyCart:(UIButton *)button {
    // 切换编辑状态
    self.isEditing = !_isEditing;
    // 设置导航栏按钮
    [self configRightBarButtonItemWithTitle:_isEditing ? @"完成" : @"编辑"];
    // 切换cell全选状态
    [self setSelectAll:!_isEditing];
    // 刷新表格和工具条
    [self reloadData:YES fromFile:NO];
    
}

#pragma mark - 工具条点击事件:点击全选按钮、删除按钮或结算按钮
- (void)cartToolBar:(UIView *)toolBar didClickButton:(UIButton *)button {
    if (button.tag == 0) {          // 切换全选状态
        // 切换全选状态
        self.selectAll = !button.selected;
        // 刷新表格和工具条
        [self reloadData:YES fromFile:NO];
    }
    if (button.tag == 3) {          // 删除

        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"真的不买了?" message:@"机不可失,失不再来哦!" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
        [alertView show];
    }
}

#pragma mark - cell上的按钮点击事件:点击选中按钮或加、减按钮
- (void)tableViewCell:(SCCartTableCell *)cell atIndexPath:(NSIndexPath *)indexPath didClickButtonAtIndex:(NSInteger)index {
    if (index == 0) {
        // 切换cell选中状态
        [self switchSelectedStateForCell:cell AtIndexPath:indexPath];
    } else {
        // 删除1件商品
        [SCCartTool buyMoreProduct:self.products[indexPath.row] count:(index - 1) ? @"1" : @"-1"];
        // 刷新页当前面数据
        [self reloadData:YES fromFile:YES];
    }
}

#pragma mark 切换cell选中状态
- (void)switchSelectedStateForCell:(SCCartTableCell *)cell AtIndexPath:(NSIndexPath *)indexPath {
    // 切换cell选中状态
    NSString *cellState = [self.cellItems[indexPath.row] boolValue] ? SC_NO_string : SC_YES_string;
    [self.cellItems replaceObjectAtIndex:indexPath.row withObject:cellState];
    // 刷新表格和工具条
    [self reloadData:YES fromFile:NO];
}

#pragma mark - 通知TabBar修改购物车数字
- (void)postNotificationToTabBarVC {
    [[NSNotificationCenter defaultCenter] postNotificationName:SCProductBuyCountDidChangeNotification object:nil];
}

#pragma mark - <UIAlertViewDelegate>
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.cellItems enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            if (obj.boolValue) {
                SCProductInfo *product = self.products[idx];
                [SCCartTool removeProductWithSkuId:product.skuId];
            }
        }];
        self.selectAll = NO;
        [self reloadData:YES fromFile:YES];
    }
}

#pragma mark - <UITableViewDataSource>
#pragma mark  有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
#pragma mark  每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

#pragma mark  cell长什么样
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCCartTableCell *cell = [SCCartTableCell cellWithTableView:tableView];
    // 设置cell
    cell.productInfo = self.products[indexPath.row];
    cell.delegate = self;
    [cell setCellItems:self.cellItems forIndexPath:indexPath];

    return cell;
}
#pragma mark - <UITableViewDelegate>
#pragma mark  cell长多高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}

#pragma mark 选中后做什么
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 设置选中效果
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 取出模型
    SCProductInfo *selectedProductInfo = self.products[indexPath.row];
    // 页面跳转
//    self.hidesBottomBarWhenPushed = YES;
    SCProductMainController *detailVC
    = [[SCProductMainController alloc] initWithSkuId:selectedProductInfo.skuId];
//    [self.navigationController pushViewController:detailVC animated:YES];

}

@end
