//
//  XXInteractionNotificationCell.h
//  XXInteractionNotificationDemo
//
//  Created by cash on 23/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XXInteractionNotificationLayout.h"

@interface XXInteractionNotificationProfileView : UIView
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel     *nameLabel;
@property (nonatomic, strong) UILabel     *holderTextLabel;
@property (nonatomic, assign) XXInteractionNotificationType interactionNotificationType;
@property (nonatomic, assign) XXInteractionNotificationEntryType entryType;
@end

@interface XXInteractionNotificationOriginalCommentView : UIView
@property (nonatomic, strong) UILabel     *originalCommentLabel;
@end

@interface XXInteractionNotificationPraiseListView : UIView
@property (nonatomic, copy) NSArray<NSString *> *praiseList;
@end

@interface XXInteractionNotificationView : UIView
@property (nonatomic, strong) UIView            *contentView;
@property (nonatomic, strong) XXInteractionNotificationProfileView *profileView;
@property (nonatomic, strong) UILabel           *commentTextLabel;
@property (nonatomic, strong) UILabel           *rightTextLabel;
@property (nonatomic, strong) UIImageView       *rightImageView;
@property (nonatomic, strong) UIImageView       *playIconView;
@property (nonatomic, strong) UILabel           *rightRemovedLabel;
@property (nonatomic, strong) XXInteractionNotificationOriginalCommentView *originalCommentView;
@property (nonatomic, strong) XXInteractionNotificationPraiseListView      *praiseListView;
@property (nonatomic, strong) UILabel           *timeLabel;
@property (nonatomic, strong) CALayer           *bottomLine;
@property (nonatomic, strong) XXInteractionNotificationLayout *interactionNotificationLayout;
@end

@interface XXInteractionNotificationCell : UITableViewCell

@property (nonatomic, strong) XXInteractionNotificationView *interactionNotificationView;
- (void)setInteractionNotificationLayout:(XXInteractionNotificationLayout *)layout;
+ (NSString *)cellId;

@end
