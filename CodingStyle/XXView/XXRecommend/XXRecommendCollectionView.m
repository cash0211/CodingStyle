//
//  XXRecommendCollectionView.m
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXRecommendCollectionView.h"
#import "XXRecommendCell.h"

@implementation XXRecommendCollectionView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (nil == self) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    self.backgroundView = [UIView new];
    self.pagingEnabled = YES;
    self.showsHorizontalScrollIndicator = NO;
    self.clipsToBounds = NO;
    return self;
}

- (XXRecommendCell *)cellForTouches:(NSSet<UITouch *> *)touches {
    UITouch *touch = touches.anyObject;
    CGPoint point = [touch locationInView:self];
    NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
    if (indexPath) {
        XXRecommendCell *cell = (id)[self cellForItemAtIndexPath:indexPath];
        return cell;
    }
    return nil;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    XXRecommendCell *cell = [self cellForTouches:touches];
    if (cell) {
        if ([self.delegate respondsToSelector:@selector(recommendCollectionViewDidTapCell:)]) {
            [((id<XXRecommendCollectionViewDelegate>)self.delegate) recommendCollectionViewDidTapCell:cell];
        }
    }
}

@end
