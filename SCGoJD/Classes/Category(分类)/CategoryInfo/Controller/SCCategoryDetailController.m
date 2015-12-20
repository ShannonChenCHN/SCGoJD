//
//  SCCategoryDetailController.m
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCCategoryDetailController.h"
#import "SCCategoryCommon.h"
#import "SCDetailCategoryCell.h"
#import "SCCollectionHeaderView.h"
#import "SCNavigationController.h"

#import "SCCategoryDetail.h"

#import "SCProductListController.h"
#import "SCCategoryViewController.h"

#import "SCCatelogListTool.h"
#import "UIImageView+WebCache.h"

@interface SCCategoryDetailController ()

// 保存模型(SCCategoryDetail)
@property (nonatomic, strong) NSMutableArray *detailCategoryList;
// 记录上一次的请求队列
@property (nonatomic, strong) AFHTTPRequestOperation *headerOperation;
// 记录上一次的请求队列(AFHTTPRequestOperation)
@property (nonatomic, strong) NSMutableArray *detailOperations;

@end

@implementation SCCategoryDetailController

static NSString * const reuseIdentifierForCell = @"Cell";
static NSString * const reuseIdentifierForHeaderView = @"HeaderView";

#pragma mark - 懒加载
- (NSMutableArray *)detailCategoryList {
    if (_detailCategoryList == nil) {
        _detailCategoryList = [NSMutableArray array];
    }
    return _detailCategoryList;
}

- (NSMutableArray *)detailOperations {
    if (_detailOperations == nil) {
        _detailOperations = [NSMutableArray array];
    }
    return _detailOperations;
}

#pragma mark - 初始化
- (instancetype)init {
    
    return [super initWithCollectionViewLayout:[self flowLayout]];
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置cell的尺寸
    flowLayout.itemSize = CGSizeMake((SCMainScreenBounds.size.width - SCCategoryMenuWidth) / 3, 100);
    flowLayout.headerReferenceSize = CGSizeMake(SCMainScreenBounds.size.width, 30);
    
    // 清空间距
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 10;
    
    return flowLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    // 注册cell
    [self.collectionView registerClass:[SCDetailCategoryCell class] forCellWithReuseIdentifier:reuseIdentifierForCell];
    // 注册headerView
    [self.collectionView registerClass:[SCCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierForHeaderView];
    
    // 不显示滚动条, 不允许下拉
    self.collectionView.bounces = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadHeaderCategoryData:)
                                                 name:SCDetailCategoryDataWillLoadNotification
                                               object:nil];

}

#pragma mark - 销毁时调用,移除通知
- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 请求数据
#pragma mark 1. 取消上一次的请求
- (void)cancelLastRequest {
    // 停止上一次的请求
    [_headerOperation pause];
    if (self.detailOperations.count) {
        for (AFHTTPRequestOperation *operation in self.detailOperations) {
            [operation pause];
        }
        [self.detailOperations removeAllObjects];
    }
    // 停止所有下载
    [[SDWebImageManager sharedManager] cancelAll];
    // 移除上一次的所有数据
    [self.detailCategoryList removeAllObjects];
}

#pragma mark 2. 请求二级分类数据(1.用于显示组的头标题2.用于请求详细分类数据)
- (void)loadHeaderCategoryData:(NSNotification *)notification {
    // 取消上一次的请求
    [self cancelLastRequest];
    // 发起(新)请求
    AFHTTPRequestOperation *headerOperation
    = [SCCatelogListTool GETCatelogyListWithLevel:@"0" catelogyId:notification.object success:^(NSArray *catelogyList) {

        // 遍历结果数组, 请求详细分类数据
        [self requestDetailCategoryDataWithCatelogyList:catelogyList];
        
    } failure:^(NSError *error) {
        SCLog(@"请求header分类信息出错:%@", error);
    }];
    
    // 保存当前请求操作
    _headerOperation = headerOperation;
}

#pragma mark 3. 根据二级分类数据, 请求详细分类数据
- (void)requestDetailCategoryDataWithCatelogyList:(NSArray *)catelogyList {
    
    // 遍历结果数组, 请求详细分类数据
    [catelogyList enumerateObjectsUsingBlock:
     ^(SCCategory *headerCategory, NSUInteger idx, BOOL *stop) {
         
         SCCategoryDetail *detailCategory = [[SCCategoryDetail alloc] init];
         // 1. 获取返回的headerCategory
         detailCategory.headerCategory = headerCategory;
         // 2. 添加headerCategory至模型数组
         [self.detailCategoryList addObject:detailCategory];
         
         // 3. 获取headerCategory对应的详细分类列表
         [self loadDetailCategoryDataWithCatelogId:headerCategory.cid forSection:idx];
     }];
    
    // 注意：得到数据后，一定要刷新列表
    [self.collectionView reloadData];
}

#pragma mark 4. 请求三级分类数据
- (void)loadDetailCategoryDataWithCatelogId:(NSString *)catelogId forSection:(NSUInteger)index {
    AFHTTPRequestOperation *detailOperation
    = [SCCatelogListTool GETCatelogyListWithLevel:@"1" catelogyId:catelogId success:^(NSArray *catelogyList) {
        if (self.detailCategoryList.count) {
            SCCategoryDetail *detailCategory = self.detailCategoryList[index];
            detailCategory.categories = catelogyList;
        }
        // 注意：得到数据后，一定要刷新列表
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        SCLog(@"请求详细分类信息出错:%@", error);
    }];
    // 保存当前请求操作
    [self.detailOperations addObject:detailOperation];
}

#pragma mark - <UICollectionViewDataSource>
#pragma mark 有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return self.detailCategoryList.count;
}

#pragma mark 每组有多少个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    SCCategoryDetail *detailCategory = self.detailCategoryList[section];
    return detailCategory.categories.count;
}
#pragma mark cell长什么样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    SCDetailCategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifierForCell forIndexPath:indexPath];
    // 取出模型数据
    SCCategoryDetail *detailCategory = self.detailCategoryList[indexPath.section];
    cell.category = detailCategory.categories[indexPath.row];
    
    
    return cell;
}
#pragma mark 附加控件长什么样
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    SCCollectionHeaderView *reusableView = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
        SCCollectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifierForHeaderView forIndexPath:indexPath];
        
        reusableView = headerView;
    }
    
    // 取出模型数据
    SCCategoryDetail *detailCategory = self.detailCategoryList[indexPath.section];
    reusableView.headerTitle = detailCategory.headerCategory.name;
    
    return reusableView;
}

#pragma mark - <UICollectionViewDelegate>
#pragma mark 选中cell时做什么
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    // 取出模型数据
    SCCategoryDetail *detailCategory = self.detailCategoryList[indexPath.section];
    SCCategory *selectedCategory = detailCategory.categories[indexPath.row];
    
    // 跳转
    SCProductListController *productListVC = [[SCProductListController alloc] initWithCatelogyId:selectedCategory.cid];
    SCNavigationController *navigationVC = [[SCNavigationController alloc] initWithRootViewController:productListVC];
    if ([self.view.superview.nextResponder isKindOfClass:[SCCategoryViewController class]]) {
        SCCategoryViewController *categoryVC = (SCCategoryViewController *)self.view.superview.nextResponder;
        categoryVC.hidesBottomBarWhenPushed = YES;
        categoryVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [categoryVC presentViewController:navigationVC animated:YES completion:nil];
    }
    
    
    
}

#pragma mark 是否可点击

@end
