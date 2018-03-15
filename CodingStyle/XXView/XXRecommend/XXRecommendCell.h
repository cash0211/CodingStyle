//
//  XXRecommendCell.h
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <UIKit/UIKit.h>

@class XXRecommendItem;
@interface XXRecommendCell : UICollectionViewCell
@property (nonatomic, strong) XXRecommendItem *item;
+ (NSString *)cellId;
@end

@interface XXRecommendPlaceHolderCell : UICollectionViewCell
+ (NSString *)cellId;
@end
