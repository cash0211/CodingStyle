//
//  XXRecommendView.h
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <UIKit/UIKit.h>

extern const NSInteger kViewHeightWithSinglePage;
extern const NSInteger kViewHeightWithMultiplePages;

@class XXRecommendItem;
@protocol XXRecommendViewDelegate <NSObject>
- (void)recommendCollectionViewDidTapCell:(XXRecommendItem *)item;
@end

@interface XXRecommendView : UIView

@property (nonatomic, weak) id<XXRecommendViewDelegate> delegate;
- (instancetype)initWithItems:(NSArray<XXRecommendItem *> *)items;

@end
