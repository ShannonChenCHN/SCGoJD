//
//  SCProductMainController.m
//  SCGoJD
//
//  Created by mac on 15/9/26.
//  Copyright (c) 2015年 mac. All rights reserved.
//  商品具体信息页面的控制器(只有在成功请求到数据时,用户才能操作工具条)

#import "SCProductMainController.h"
#import "SCProductToolCommon.h"
#import "SCTitleView.h"
#import "SCBuyerToolBar.h"
#import "SCProductMainCell.h"

#import "SCProductTableController.h"
#import "SCDetailWebController.h"
#import "SCCommentWebController.h"

#import "SCNavigationController.h"

#import "SCMyProductItem.h"
#import "SCProductInfo.h"

#import "UICollectionViewController+SCCurrentPage.h"

@interface SCProductMainController ()   <SCTitleViewDelegate, SCBuyerToolBarDelegate>

// 流水布局
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
// 商品编号skuId
@property (nonatomic, copy) NSString *skuId;
// 商品信息
@property (nonatomic, strong) SCProductInfo *productInfo;
// 子视图的控制器
@property (nonatomic, strong) SCProductTableController *productVC;
@property (nonatomic, strong) SCDetailWebController *detailVC;
@property (nonatomic, strong) SCCommentWebController *commentVC;
// 当前所滚动到的页码
@property (nonatomic, assign) NSUInteger pageNumber;
// 用户购买收藏的工具栏
@property (nonatomic, strong) SCBuyerToolBar *toolBar;
// 反映用户与商品关系的模型
@property (nonatomic, strong) SCMyProductItem *item;
// 选择要购买该商品的数量
@property (nonatomic, copy) NSString *buyCount;

@end

@implementation SCProductMainController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - 懒加载
- (SCProductTableController *)productVC {
    if (_productVC == nil) {
        _productVC = [[SCProductTableController alloc] initWithSkuId:_skuId];
    }
    return _productVC;
}

- (SCDetailWebController *)detailVC {
    if (_detailVC == nil) {
        _detailVC = [[SCDetailWebController alloc] initWithSkuId:_skuId];
    }
    return _detailVC;
}

- (SCCommentWebController *)commentVC {
    if (_commentVC == nil) {
        _commentVC = [[SCCommentWebController alloc] initWithSkuId:_skuId];
    }
    return _commentVC;
}

- (SCMyProductItem *)item {
    if (_item == nil) {
        _item = [[SCMyProductItem alloc] init];
        
    }
    return _item;
}

#pragma mark - 初始化
- (instancetype)initWithSkuId:(NSString *)skuId {
    
    self = [super initWithCollectionViewLayout:self.flowLayout];
    
    if (self) {
        _skuId = skuId;
    }
    
    return self;
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    if (_flowLayout == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        // 设置cell的尺寸
        CGFloat Y = 64;//CGRectGetMaxY(self.navigationController.navigationBar.frame);
        flowLayout.itemSize = CGSizeMake(SCMainScreenBounds.size.width,
                                         SCMainScreenBounds.size.height - Y - SCBuyerToolBarHeight);
        // 清空行距
        flowLayout.minimumLineSpacing = 0;
        // 设置滚动方向:水平
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout = flowLayout;
    }
    
    return _flowLayout;
}

#pragma mark - 加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.frameHeight -= SCBuyerToolBarHeight;
    
    // 注册cell
    [self.collectionView registerClass:[SCProductMainCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 以下的属性都是继承自UIScrollView
    self.collectionView.pagingEnabled = YES;                        // 按页翻转
    self.collectionView.bounces = NO;                               // 拉到底无反弹效果
    self.collectionView.showsHorizontalScrollIndicator = NO;        //不显示滚动条

    // 设置导航条
    [self setNavigationBar];
    
    // 添加工具条
    [self addToolBar];

    // 添加观察者
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setProductInfo:) name:SCProductInfoDidRecievedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeSelectionCount:) name:SCSelectedProductCountDidChangeNotification object:nil];
    
    // 默认已选1件商品
    _buyCount = @"1";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 调整工具条位置
    _toolBar.originY = self.view.frameHeight - SCBuyerToolBarHeight;
    
}

#pragma mark - 设置导航条
- (void)setNavigationBar {
    
    // 1. 中间添加3个按钮
    SCTitleView *titleView = [[SCTitleView alloc] init];
    titleView.delegate = self;
    self.navigationItem.titleView = titleView;
    
    // 3. 左侧返回
    self.navigationItem.leftBarButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage imageNamed:@"back_bt"]
                                       highlightedImage:nil
                                                 target:self
                                                 action:@selector(back)
                                       forControlEvents:UIControlEventTouchUpInside];
    
    // 5. 右侧按钮
    UIBarButtonItem *moreButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage originalImageNamed:@"jshop_more_normal"]
                                       highlightedImage:nil
                                                 target:self
                                                 action:@selector(moreChoice)
                                       forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *footprintButtonItem
    = [UIBarButtonItem barButtonItemWithBackgroundImage:[UIImage originalImageNamed:@"ware_histroy"]
                                       highlightedImage:nil
                                                 target:self
                                                 action:@selector(viewMyHistory)
                                       forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItems = @[moreButtonItem, footprintButtonItem];
    
}

#pragma mark －添加工具条
- (void)addToolBar {
    SCBuyerToolBar *toolBar = [[SCBuyerToolBar alloc] init];
    
    self.item.focused = [SCFocusTool hasFocusedProductWithSkuId:_skuId];
    self.item.productCount = [SCCartTool totalCount];
    toolBar.item = self.item;
    
    _toolBar = toolBar;
    [self.view addSubview:toolBar];
}

#pragma mark - 更多操作
- (void)moreChoice {
    
}

#pragma mark - 查看浏览记录
- (void)viewMyHistory {
    
}

#pragma mark - 返回
- (void)back {
    
    if ([self.presentingViewController isKindOfClass:[SCNavigationController class]]) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 一有数据就可以进行操作
- (void)setProductInfo:(NSNotification *)notification {
    _productInfo = notification.object;
    _productInfo.skuId = _skuId;
    // 保存记录
    [SCHistoryTool saveNewHistory:_productInfo];
    // 设置toolBar的代理,有数据才可以点击
    _toolBar.delegate = self;

}

#pragma mark - 改变购买数量时调用
- (void)changeSelectionCount:(NSNotification *)notification {
    _buyCount = notification.object;

    if (_buyCount.longLongValue < 0 ||
        _buyCount.length == 0) {
        _buyCount = @"1";
    }
}

#pragma mark - <UIScrollViewDelegate>
#pragma mark 一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取当前的位置, 计算当前页
    CGFloat offset = scrollView.contentOffset.x;

    NSUInteger currentPageNumber
    = [self setCurrentPageNumberWithLastPageNumber:_pageNumber totalCount:3 offset:offset];
    
    if (_pageNumber != currentPageNumber) {
        
        NSString *num = [NSString stringWithFormat:@"%li", currentPageNumber];
        // 发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:SCCurrentPageDidChangeNotification object:num];
        
        _pageNumber = currentPageNumber;
    }
}

#pragma mark - 点击titleView按钮时的响应 <SCTitleViewDelegate>
- (void)titleView:(SCTitleView *)titleView didClickButtonAtIndex:(NSUInteger)index {

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - 点击BuyerToolBar按钮时的响应 <SCBuyerToolBarDelegate>
- (void)toolBar:(SCBuyerToolBar *)toolBar didClickButtonAtIndex:(NSUInteger)index {
/**
 *  1. 点击关注按钮时，首先判断该商品是否被关注，没有则添加至关注的商品数组中，保存至本地
 *     同时重新给toolBar的item赋值，反之亦然。
 *  2. 点击购车时，跳转至购物车页面。
 *  3. 点击加入购物车按钮时，从cell2中读取购买数量，重新计算购物车中商品数量，保存至本地，
 *     同时重新给toolBar的item赋值，反之亦然。
 *
 */
    if (index == 0) {           // 加入购物车
        [SCCartTool buyProduct:_productInfo count:_buyCount];
        _toolBar.item.productCount = [SCCartTool totalCount];
        
    } else if (index == 1) {         // 关注
        if ([SCFocusTool hasFocusedProductWithSkuId:_skuId].length) {   // 取消关注
            [SCFocusTool removeFocusedProductWithskuId:_productInfo.skuId];
             _toolBar.item.focused = @"";
            
        } else {                                                // 添加关注
            [SCFocusTool focusProduct:_productInfo];
            _toolBar.item.focused = SC_YES_string;
        }

    }
    
}

#pragma mark <UICollectionViewDataSource>
// 有几组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

// 每组有几个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 3;
}
// 设置每个cell的内容，cell长什么样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SCProductMainCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    if (indexPath.row == 0) {
        self.productVC.view.frame = cell.bounds;
        cell.contentSubview = self.productVC.view;
    } else if (indexPath.row == 1) {
        self.detailVC.view.frame = cell.bounds;
        cell.contentSubview = self.detailVC.view;
    } else if (indexPath.row == 2) {
        self.commentVC.view.frame = cell.bounds;
        cell.contentSubview = self.commentVC.view;
    } 
    
    return cell;
}

#pragma mark - 移除通知观察者
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
