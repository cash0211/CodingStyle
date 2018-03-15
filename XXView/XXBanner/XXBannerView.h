//
//  XXBannerView.h
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXBannerItem;

@protocol XXBannerViewDelegate <NSObject>
- (void)bannerImageViewDidTaped:(XXBannerItem *)item;
@end

@interface XXBannerView : UIView

@property (nonatomic, weak) id<XXBannerViewDelegate> delegate;

- (instancetype)initWithItems:(NSArray<XXBannerItem *> *)items;
- (void)startBackupTimer;
- (void)endBackupTimer;

@end
