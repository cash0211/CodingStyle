//
//  XXRecommendCollectionView.h
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXRecommendCell;
@protocol XXRecommendCollectionViewDelegate <UICollectionViewDelegate>
- (void)recommendCollectionViewDidTapCell:(XXRecommendCell *)cell;
@end

@interface XXRecommendCollectionView : UICollectionView

@end
