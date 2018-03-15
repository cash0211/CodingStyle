//
//  XXMyFollowAndHotCircleInnerTopView.h
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, XXInnerType) {
    XXInnerTypeNone = 0,
    XXInnerTypeMyFollow,
    XXInnerTypeHotCircle,
    XXInnerTypeAllCircle,
};

@protocol XXMyFollowAndHotCircleInnerTopViewDelegate <NSObject>
- (void)myFollowAndHotCircleInnerTopViewDidTap:(XXInnerType)type;
@end

@interface XXMyFollowAndHotCircleInnerTopView : UIView

@property (nonatomic, weak) id<XXMyFollowAndHotCircleInnerTopViewDelegate> delegate;
- (instancetype)initWithIsLogin:(BOOL)isLogin;

@end
