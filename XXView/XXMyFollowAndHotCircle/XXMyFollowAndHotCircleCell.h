//
//  XXMyFollowAndHotCircleCell.h
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXHotModel;
@interface XXMyFollowAndHotCircleCell : UICollectionViewCell
@property (nonatomic, strong) XXHotModel *item;
+ (NSString *)cellId;
@end

@interface XXMyFollowAndHotCircleMoreCell : UICollectionViewCell
+ (NSString *)cellId;
@end
