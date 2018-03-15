//
//  XXRecommendView.m
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXRecommendView.h"
#import "XXRecommendCollectionView.h"
#import "XXRecommendCell.h"
#import "XXRecommendModel.h"

#import "YYCGUtilities.h"
#import "UIView+YYAdd.h"
#import "CALayer+YYAdd.h"
#import "UIColor+YYAdd.h"

typedef NS_ENUM(NSUInteger, XXRecommendViewEntryType) {
    XXRecommendViewEntryTypeNone = 0,
    XXRecommendViewEntryTypeSinglePage,
    XXRecommendViewEntryTypeMultiplePages,
};

       const NSInteger kViewHeightWithSinglePage    = 0;
       const NSInteger kViewHeightWithMultiplePages = 0;
static const NSInteger kOnePageCount                = 5;
static const NSInteger kCollectionViewHeight        = 0;

@interface XXRecommendView() <UICollectionViewDelegate, UICollectionViewDataSource, XXRecommendCollectionViewDelegate>

@property (nonatomic, strong) XXRecommendCollectionView  *recommendCollectionView;
@property (nonatomic, strong) UIView                     *pageControl;

@property (nonatomic, copy)   NSArray<XXRecommendItem *> *items;
@property (nonatomic, assign) XXRecommendViewEntryType    entryType;
@property (nonatomic, assign) NSInteger                   itemTotalPageCount;
@property (nonatomic, copy)   NSArray<NSNumber *>        *numberOfItemsInSection;
@property (nonatomic, assign) NSInteger                   currentPageIndex;

@end

@implementation XXRecommendView

#pragma mark - Lifecycle

- (instancetype)initWithItems:(NSArray<XXRecommendItem *> *)items {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
    if (nil == self) {
        return nil;
    }
    if (nil == items || 0 == items.count) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    self.items = items.copy;
    self.currentPageIndex = NSNotFound;
    NSInteger count = items.count;
    self.itemTotalPageCount = count / kOnePageCount;
    if (0 != count % kOnePageCount) {
        self.itemTotalPageCount += 1;
    }
    NSMutableArray *numberOfItemsInSection = @[].mutableCopy;
    for (NSInteger i = 0; i < self.itemTotalPageCount; ++i) {
        [numberOfItemsInSection addObject:@(kOnePageCount)];
    }
    self.numberOfItemsInSection = numberOfItemsInSection.copy;
    
    if (1 == self.itemTotalPageCount) {
        self.entryType = XXRecommendViewEntryTypeSinglePage;
    } else {
        self.entryType = XXRecommendViewEntryTypeMultiplePages;
    }
    
    [self setUpViews];
    switch (self.entryType) {
        case XXRecommendViewEntryTypeSinglePage:
            self.size = CGSizeMake(kScreenWidth, kViewHeightWithSinglePage);
            self.pageControl.hidden = YES;
            break;
        case XXRecommendViewEntryTypeMultiplePages:
            self.size = CGSizeMake(kScreenWidth, kViewHeightWithMultiplePages);
            self.pageControl.hidden = NO;
            break;
        default:
            break;
    }
    [self scrollViewDidScroll:self.recommendCollectionView];
    return self;
}

- (void)setUpViews {
    CGFloat itemWidth = self.width / kOnePageCount;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(itemWidth, kCollectionViewHeight);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    XXRecommendCollectionView *recoCollectionView = [[XXRecommendCollectionView alloc]
                                                     initWithFrame:CGRectMake(0, 0, self.width, kCollectionViewHeight)
                                                     collectionViewLayout:layout];
    [recoCollectionView registerClass:[XXRecommendCell class] forCellWithReuseIdentifier:[XXRecommendCell cellId]];
    [recoCollectionView registerClass:[XXRecommendPlaceHolderCell class] forCellWithReuseIdentifier:[XXRecommendPlaceHolderCell cellId]];
    recoCollectionView.delegate = self;
    recoCollectionView.dataSource = self;
    self.recommendCollectionView = recoCollectionView;
    
    UIView *pageControl = [UIView new];
    pageControl.size = CGSizeMake(self.width, 4);
    pageControl.bottom = kViewHeightWithMultiplePages - 10;
    pageControl.userInteractionEnabled = NO;
    self.pageControl = pageControl;
    
    [self addSubview:self.recommendCollectionView];
    [self addSubview:self.pageControl];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.itemTotalPageCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.numberOfItemsInSection[section].integerValue;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    NSInteger index = section * kOnePageCount + row;
    if (index < self.items.count) {
        XXRecommendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[XXRecommendCell cellId] forIndexPath:indexPath];
        XXRecommendItem *item = self.items[index];
        item.index = index;
        cell.item = item;
        return cell;
    } else {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[XXRecommendPlaceHolderCell cellId] forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark - XXRecommendCollectionViewDelegate

- (void)recommendCollectionViewDidTapCell:(XXRecommendCell *)cell {
    if ([cell isKindOfClass:[XXRecommendCell class]]) {
        if ([self.delegate respondsToSelector:@selector(recommendCollectionViewDidTapCell:)]) {
            [self.delegate recommendCollectionViewDidTapCell:cell.item];
        }
    }
}

#pragma mark - ScrollViewDidScroll

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSInteger page = round(scrollView.contentOffset.x / scrollView.width);
    if (page < 0) page = 0;
    else if (page >= self.itemTotalPageCount) { page = self.itemTotalPageCount - 1; }
    if (page == self.currentPageIndex) { return; }
    self.currentPageIndex = page;
    
    [self.pageControl.layer removeAllSublayers];
    CGFloat padding = 3, layerSize = 4;
    CGFloat pageControlWidth = (layerSize + 2 * padding) * self.itemTotalPageCount;
    for (NSInteger i = 0; i < self.itemTotalPageCount; ++i) {
        CALayer *layer = [CALayer layer];
        layer.size = CGSizeMake(layerSize, layerSize);
        layer.cornerRadius = 2;
        if (page == i) {
            layer.backgroundColor = UIColorHex(FF9238).CGColor;
        } else {
            layer.backgroundColor = UIColorHex(E0E0E0).CGColor;
        }
        layer.centerY = self.pageControl.height / 2;
        layer.left = (self.pageControl.width - pageControlWidth) / 2 + i * (layerSize + 2 * padding) + padding;
        [_pageControl.layer addSublayer:layer];
    }
}

@end
