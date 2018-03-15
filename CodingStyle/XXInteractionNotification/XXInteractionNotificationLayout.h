//
//  XXInteractionNotificationLayout.h
//  XXInteractionNotificationDemo
//
//  Created by cash on 23/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class XXInteractionNotificationItem;

static const NSInteger kInteractionNotificationTopMargin    = 0;
static const NSInteger kInteractionNotificationBottomMargin = 0;
static const NSInteger kInteractionNotificationLeftPadding  = 0;
static const NSInteger kInteractionNotificationRightPadding = 0;

static const NSInteger kInteractionNotificationProfileHeight         = 0;
static const NSInteger kInteractionNotificationNamePaddingLeft       = 0;
static const NSInteger kInteractionNotificationHolderTextPaddingLeft = 0;

static const NSInteger kInteractionNotificationNoCommentContentPaddingBottom = 0;
static const NSInteger kInteractionNotificationCommentContentPaddingTop      = 0;
static const NSInteger kInteractionNotificationCommentContentPaddingBottom   = 0;
static const NSInteger kInteractionNotificationCommentContentWidth           = 0;
static const NSInteger kInteractionNotificationCommentContentWidth5Series    = 0;
static const NSInteger kInteractionNotificationRightContentWidth             = 0;
static const NSInteger kInteractionNotificationTimeLabelHeight               = 0;

static const NSInteger kInteractionNotificationOriginalCommentWidth          = 0;
static const NSInteger kInteractionNotificationOriginalCommentPaddingTop     = 0;
static const NSInteger kInteractionNotificationOriginalCommentPaddingLeft    = 0;

static const NSInteger kInteractionNotificationCommentContentFontSize        = 0;
static const NSInteger kInteractionNotificationReplyContentFontSize          = 0;
static const NSInteger kInteractionNotificationRightContentFontSize          = 0;
static const NSInteger kInteractionNotificationOriginalCommentFontSize       = 0;
static const NSInteger kInteractionNotificationNameFontSize                  = 0;


typedef NS_ENUM(NSUInteger, XXInteractionNotificationType) {
    XXInteractionNotificationTypeNone                 = 200,
    XXInteractionNotificationTypeArticalComment       = 201,
    XXInteractionNotificationTypePostComment          = 202,
    XXInteractionNotificationTypeArticalCommentReply  = 203,
    XXInteractionNotificationTypePostCommentReply     = 204,
    XXInteractionNotificationTypePraiseArtical        = 205,
    XXInteractionNotificationTypePraisePost           = 206,
    XXInteractionNotificationTypePraiseArticalComment = 207,
    XXInteractionNotificationTypePraisePostComment    = 208,
    XXInteractionNotificationTypePraise               = 209,
};

typedef NS_ENUM(NSUInteger, XXInteractionNotificationEntryType) {
    XXInteractionNotificationEntryTypeNone = 0,
    XXInteractionNotificationEntryTypeMain,
    XXInteractionNotificationEntryTypePraiseDetail,
};

static NSString *const XXInteractionNotificationHolderTextTypeArtical = @"FFFFFF";
static NSString *const XXInteractionNotificationHolderTextTypePost    = @"FFFFFF";
static NSString *const XXInteractionNotificationHolderTextTypeComment = @"FFFFFF";
static NSString *      XXInteractionNotificationHolderTextTypePraise  = @"FFFFFF";

static NSString *const XXInteractionNotificationHolderTextTypePostRemoved    = @"FFFFFF";
static NSString *const XXInteractionNotificationHolderTextTypeArticalRemoved = @"FFFFFF";
static NSString *const XXInteractionNotificationHolderTextTypeCommentRemoved = @"FFFFFF";
static NSString *const XXInteractionNotificationHolderTextTypeOriginalCommentRemoved = @"FFFFFF";

static NSString *const XXInteractionNotificationPraiseDetailHolderText            = @"FFFFFF";
static NSString *const XXInteractionNotificationPraiseDetailHolderTextTypeArtical = @"FFFFFF";
static NSString *const XXInteractionNotificationPraiseDetailHolderTextTypePost    = @"FFFFFF";
static NSString *const XXInteractionNotificationPraiseDetailHolderTextTypeComment = @"FFFFFF";

@interface XXInteractionNotificationLayout : NSObject

- (instancetype)initWithInteractionNotificationItem:(XXInteractionNotificationItem *)interactionNotificationItem
                                               type:(XXInteractionNotificationType)interactionNotificationType
                                          entryType:(XXInteractionNotificationEntryType)entryType;
+ (BOOL)updateConstraintIfNeeded;

@property (nonatomic, strong) XXInteractionNotificationItem *interactionNotificationItem;
@property (nonatomic, assign) XXInteractionNotificationType interactionNotificationType;
@property (nonatomic, assign) XXInteractionNotificationEntryType interactionNotificationEntryType;

@property (nonatomic, assign) CGFloat marginTop;
@property (nonatomic, assign) CGFloat profileHeight;
@property (nonatomic, assign) CGFloat nameWidth;

@property (nonatomic, assign) CGFloat commentTextHeight;
@property (nonatomic, assign) CGFloat rightTextHeight;
@property (nonatomic, assign) CGFloat originalCommentHeight;
@property (nonatomic, assign) CGFloat replyContentHeight;

@property (nonatomic, assign) CGFloat timeTextHeight;
@property (nonatomic, assign) CGFloat praiseListHeight;
@property (nonatomic, copy)   NSString *timeString;
@property (nonatomic, assign) CGFloat marginBottom;
@property (nonatomic, assign) CGFloat height;

@end
