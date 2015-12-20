//
//  SCNewFeatureController.m
//  SCGoJD
//
//  Created by mac on 15/9/22.
//  Copyright (c) 2015年 mac. All rights reserved.
//


// 使用UICollectionView的步骤：
// 1. 初始化时，设置布局参数
// 2.CollectionView必须要注册cell
// 3.自定义cell

#import "SCNewFeatureController.h"
#import "SCNewFeatureCell.h"

@interface SCNewFeatureController ()

// 流水布局
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation SCNewFeatureController

static NSString * const reuseIdentifier = @"Cell";

#pragma mark - 初始化
- (instancetype)init {
    
    return [super initWithCollectionViewLayout:self.flowLayout];
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    if (_flowLayout == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        // 设置cell的尺寸
        flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
        // 清空行距
        flowLayout.minimumLineSpacing = 0;
        // 设置滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _flowLayout = flowLayout;
    }
    
    return _flowLayout;
}

#pragma mark - 加载视图
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.collectionView registerClass:[SCNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 以下的属性都是继承自UIScrollView
    self.collectionView.pagingEnabled = YES;                        // 按页翻转
    self.collectionView.bounces = NO;                               // 拉到底无反弹效果
    self.collectionView.showsHorizontalScrollIndicator = NO;        //不显示滚动条

    
}

#pragma mark <UICollectionViewDataSource>
// 有几组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
 
    return 1;
}

// 每组有几个
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 2;
}
// 设置每个cell的内容，cell长什么样
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    /* 1. 首先从缓冲池里取cell
     * 2. 检查当前是否注册了cell，如果注册了cell，就会帮你创建cell
     * 3. 如果发现没有注册，就会报错
     */
    SCNewFeatureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // 拼接图片
    NSString *imageName = [NSString stringWithFormat:@"function_guide_%li", indexPath.row + 1];
    cell.image = [UIImage imageNamed:imageName];
    
    // 设置当前页码和最后一页码
    [cell setCurrentPageIndex:indexPath.row lastPageIndex:1];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>


@end
