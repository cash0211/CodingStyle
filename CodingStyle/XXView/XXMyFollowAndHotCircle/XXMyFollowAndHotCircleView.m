//
//  XXMyFollowAndHotCircleView.m
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXMyFollowAndHotCircleView.h"
#import "XXMyFollowAndHotCircleInnerTopView.h"
#import "XXMyFollowAndHotCircleCell.h"
#import "XXHotModel.h"

#import "YYCGUtilities.h"
#import "UIView+YYAdd.h"

static const NSInteger kViewHeight           = 0;
static const NSInteger kCollectionViewHeight = 0;
static const NSInteger kLayoutEdgeLeft       = 0;
static const NSInteger kItemWidth            = 0;
static const NSInteger kItemMaxCount         = 0;

@interface XXMyFollowAndHotCircleView() <UICollectionViewDelegate, UICollectionViewDataSource, XXMyFollowAndHotCircleInnerTopViewDelegate>

@property (nonatomic, strong) XXMyFollowAndHotCircleInnerTopView *topView;
@property (nonatomic, strong) UICollectionView         *containerCollectionView;

@property (nonatomic, copy)   NSArray<XXHotModel *>    *innerItems;
@property (nonatomic, copy)   NSArray<XXHotModel *>    *myFollowItems;
@property (nonatomic, copy)   NSArray<XXHotModel *>    *hotCircleItems;
@property (nonatomic, assign) XXInnerType              innerType;
@end

@implementation XXMyFollowAndHotCircleView

#pragma mark - Lifecycle

- (instancetype)initWithMyFollowItems:(NSArray<XXHotModel *> *)myFollowItems hotCircleItems:(NSArray<XXHotModel *> *)hotCircleItems {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kViewHeight)];
    if (nil == self) {
        return nil;
    }
    if (nil == myFollowItems || nil == hotCircleItems) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    self.myFollowItems = myFollowItems.copy;
    self.hotCircleItems = hotCircleItems.copy;
    [self setUpViews];
    return self;
}

#pragma mark - Private methods

- (void)setUpViews {
    BOOL isLogin = YES; // changeable
    if (isLogin) {
        self.innerItems = self.myFollowItems;
        self.innerType = XXInnerTypeMyFollow;
    } else {
        self.innerItems = self.hotCircleItems;
        self.innerType = XXInnerTypeHotCircle;
    }
    
    XXMyFollowAndHotCircleInnerTopView *topView = [[XXMyFollowAndHotCircleInnerTopView alloc] initWithIsLogin:isLogin];
    topView.delegate = self;
    topView.top = 12;
    self.topView = topView;
    
    CGFloat minimumLineSpacing = 14;
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(kItemWidth, kCollectionViewHeight);
    layout.sectionInset = UIEdgeInsetsMake(0, kLayoutEdgeLeft, 0, kLayoutEdgeLeft);
    layout.minimumLineSpacing = minimumLineSpacing;
    layout.minimumInteritemSpacing = 0;
    UICollectionView *containerCollectionView = [[UICollectionView alloc]
                                                 initWithFrame:CGRectMake(0, 0, self.width, kCollectionViewHeight)
                                                 collectionViewLayout:layout];
    containerCollectionView.bottom = kViewHeight - 12;
    [containerCollectionView registerClass:[XXMyFollowAndHotCircleCell class] forCellWithReuseIdentifier:[XXMyFollowAndHotCircleCell cellId]];
    [containerCollectionView registerClass:[XXMyFollowAndHotCircleMoreCell class] forCellWithReuseIdentifier:[XXMyFollowAndHotCircleMoreCell cellId]];
    containerCollectionView.delegate = self;
    containerCollectionView.dataSource = self;
    containerCollectionView.backgroundColor = [UIColor clearColor];
    containerCollectionView.backgroundView = [UIView new];
    containerCollectionView.showsHorizontalScrollIndicator = NO;
    self.containerCollectionView = containerCollectionView;
    
    [self addSubview:topView];
    [self addSubview:self.containerCollectionView];
    
    if (isLogin && 0 == self.myFollowItems.count) {
        // show no content
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return MIN(self.innerItems.count, kItemMaxCount);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (kItemMaxCount - 1 == row) {
        if (self.innerType == XXInnerTypeMyFollow && self.innerItems.count > 10) {
            return [collectionView dequeueReusableCellWithReuseIdentifier:[XXMyFollowAndHotCircleMoreCell cellId] forIndexPath:indexPath];
        }
    }
    XXMyFollowAndHotCircleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[XXMyFollowAndHotCircleCell cellId] forIndexPath:indexPath];
    cell.item = self.innerItems[row];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(myFollowAndHotCircleViewDidSelectItemAtCell:)]) {
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        if ([cell isKindOfClass:[XXMyFollowAndHotCircleCell class]]) {
            [self.delegate myFollowAndHotCircleViewDidSelectItemAtCell:((XXMyFollowAndHotCircleCell *)cell).item];
        } else if ([cell isKindOfClass:[XXMyFollowAndHotCircleMoreCell class]]) {
            [self.delegate myFollowAndHotCircleViewDidSelectItemAtCell:nil];
        }
    }
}

#pragma mark - XXMyFollowAndHotCircleInnerTopViewDelegate

- (void)myFollowAndHotCircleInnerTopViewDidTap:(XXInnerType)type {
    switch (type) {
        case XXInnerTypeMyFollow: {
            if (0 == self.myFollowItems.count) {
                return;
            }
            self.innerType = type;
            self.innerItems = self.myFollowItems;
            [self scrollToLeftAnimated:NO];
            [self.containerCollectionView reloadData];
            return;
        } break;
        case XXInnerTypeHotCircle: {
            self.innerType = type;
            self.innerItems = self.hotCircleItems;
            [self scrollToLeftAnimated:NO];
            [self.containerCollectionView reloadData];
            return;
        } break;
        case XXInnerTypeAllCircle: {
            if ([self.delegate respondsToSelector:@selector(myFollowAndHotCircleInnerTopViewAllCircleDidTap)]) {
                [self.delegate myFollowAndHotCircleInnerTopViewAllCircleDidTap];
            }
        } break;
        default:
            break;
    }
}

- (void)scrollToLeftAnimated:(BOOL)animated {
    CGPoint off = self.containerCollectionView.contentOffset;
    off.x = 0 - self.containerCollectionView.contentInset.left;
    [self.containerCollectionView setContentOffset:off animated:animated];
}

@end

