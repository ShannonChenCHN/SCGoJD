//
//  SCImageScrollController.m
//  SCGoJD
//
//  Created by mac on 15/9/28.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "SCImageScrollController.h"
#import "SCImageScrollBaseCell.h"
#import "UICollectionViewController+SCCurrentPage.h"

#define SCPageNumberDidChangeNotification  @"SCPageNumberDidChange"

@interface SCImageScrollController ()
// 流水布局
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
// 要显示的图片的URL(NSString)
@property (nonatomic, strong) NSArray *imagePaths;
// 定时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation SCImageScrollController

static NSString * const reuseIdentifier = @"Cell";
#pragma mark - 懒加载
- (NSTimer *)timer {
    if (_timer == nil) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(autoScrollImage) userInfo:nil repeats:YES];
    }
    return _timer;
}

#pragma mark - 初始化
- (instancetype)initWithItemSize:(CGSize)itemSize imagePaths:(NSArray *)imagePaths {
    
    self.flowLayout.itemSize = itemSize;
    self.imagePaths = imagePaths.count?[NSArray arrayWithArray:imagePaths]:@[@"123.png"];
    
    return [super initWithCollectionViewLayout:self.flowLayout];
}

- (UICollectionViewFlowLayout *)flowLayout {
    
    if (_flowLayout == nil) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        
        // 设置cell的尺寸
//        flowLayout.itemSize = [UIScreen mainScreen].bounds.size;
        // 清空行距
        flowLayout.minimumLineSpacing = 0;
        // 设置滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _flowLayout = flowLayout;
    }
    
    return _flowLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register cell classes
    [self.collectionView registerClass:[SCImageScrollBaseCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // 以下的属性都是继承自UIScrollView
    self.collectionView.pagingEnabled = YES;                        // 按页翻转
    self.collectionView.bounces = NO;                               // 拉到底无反弹效果
    self.collectionView.showsHorizontalScrollIndicator = NO;        //不显示滚动条
    // 初始值为0
    self.currentPageNum = @"0";
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 启动计时器
    if (_timer == nil) {
        [self timer];
    } else {
        [self.timer setFireDate:[NSDate date]];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // 启动计时器
    [self.timer setFireDate:[NSDate distantFuture]];
}

#pragma mark - 图片轮播
- (void)autoScrollImage {
    
    NSInteger num = [_currentPageNum longLongValue] + 1;
    BOOL animated = YES;
    if (num == self.imagePaths.count) {
        num = 0;
        animated = NO;
    }
    if (self.imagePaths.count) {   // 注意:有数据了才滚动
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:num inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:animated];
    }
}

#pragma mark - <UIScrollViewDelegate>
#pragma mark 一滚动就会调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    // 获取当前的位置, 计算当前页
    CGFloat offset = scrollView.contentOffset.x;
    
    NSUInteger pageNum = [_currentPageNum longLongValue];
    
    NSUInteger currentPageNumber
    = [self setCurrentPageNumberWithLastPageNumber:pageNum
                                        totalCount:self.imagePaths.count
                                            offset:offset];
    
    if (pageNum != currentPageNumber) {

        _currentPageNum = [NSString stringWithFormat:@"%li", currentPageNumber];
        // 发出通知
        [[NSNotificationCenter defaultCenter] postNotificationName:SCPageNumberDidChangeNotification object:nil];
    }
}

#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.imagePaths.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    SCImageScrollBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    // 取出模型
    NSString *URLString = self.imagePaths[indexPath.row];
    cell.imagePath = [NSURL URLWithString:URLString];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

@end
