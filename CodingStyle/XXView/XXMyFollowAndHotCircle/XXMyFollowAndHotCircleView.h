//
//  XXMyFollowAndHotCircleView.h
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXHotModel;
@protocol XXMyFollowAndHotCircleViewDelegate <NSObject>
- (void)myFollowAndHotCircleInnerTopViewAllCircleDidTap;
- (void)myFollowAndHotCircleViewDidSelectItemAtCell:(XXHotModel *)item;
@end

@interface XXMyFollowAndHotCircleView : UIView

@property (nonatomic, weak) id<XXMyFollowAndHotCircleViewDelegate> delegate;
- (instancetype)initWithMyFollowItems:(NSArray<XXHotModel *> *)myFollowItems hotCircleItems:(NSArray<XXHotModel *> *)hotCircleItems;

@end
