//
//  XXInteractionNotificationCell.m
//  XXInteractionNotificationDemo
//
//  Created by cash on 23/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXInteractionNotificationCell.h"
#import "XXInteractionNotification.h"

#import "UIView+YYAdd.h"
#import "YYCGUtilities.h"
#import "UIColor+YYAdd.h"
#import "CALayer+YYAdd.h"

@implementation XXInteractionNotificationProfileView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (nil == self) {
        return nil;
    }
    self.size = CGSizeMake(kScreenWidth, kInteractionNotificationProfileHeight);
    [self setUpViews];
    return self;
}

#pragma mark - Private methods

- (void)setUpViews {
    UIImageView *avatarView = [UIImageView new];
    avatarView.contentMode = UIViewContentModeScaleAspectFill;
    self.avatarView = avatarView;
    
    UILabel *nameLabel = [UILabel new];
    nameLabel.font = [UIFont systemFontOfSize:kInteractionNotificationNameFontSize];
    nameLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    self.nameLabel = nameLabel;
    
    UILabel *holderTextLabel = [UILabel new];
    holderTextLabel.font = [UIFont systemFontOfSize:kInteractionNotificationNameFontSize];
    holderTextLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    holderTextLabel.textAlignment = NSTextAlignmentLeft;
    self.holderTextLabel = holderTextLabel;
    
    avatarView.size = CGSizeMake(28, 28);
    avatarView.left = kInteractionNotificationLeftPadding;
    avatarView.layer.cornerRadius = avatarView.height * 0.5;
    nameLabel.size = CGSizeMake(self.width - 232, 20);
    nameLabel.left = avatarView.right + kInteractionNotificationNamePaddingLeft;
    nameLabel.centerY = self.height * 0.5;
    holderTextLabel.size = CGSizeMake(102, 20);
    holderTextLabel.left = nameLabel.right + kInteractionNotificationHolderTextPaddingLeft;
    holderTextLabel.centerY = nameLabel.centerY;
    
    [self addSubview:self.avatarView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.holderTextLabel];
}

- (void)updateViewsLayout {
    self.holderTextLabel.left = self.nameLabel.right + kInteractionNotificationHolderTextPaddingLeft;
}

#pragma mark - Getters & Setters

- (void)setInteractionNotificationType:(XXInteractionNotificationType)interactionNotificationType {
    _interactionNotificationType = interactionNotificationType;
    
    if (self.entryType == XXInteractionNotificationEntryTypeMain) {
        switch (interactionNotificationType) {
            case XXInteractionNotificationTypeArticalComment: {
                self.holderTextLabel.text = XXInteractionNotificationHolderTextTypeArtical;
            } break;
            case XXInteractionNotificationTypePostComment: {
                self.holderTextLabel.text = XXInteractionNotificationHolderTextTypePost;
            } break;
            case XXInteractionNotificationTypeArticalCommentReply:
            case XXInteractionNotificationTypePostCommentReply: {
                self.holderTextLabel.text = XXInteractionNotificationHolderTextTypeComment;
            } break;
            case XXInteractionNotificationTypePraise: {
                self.holderTextLabel.text = XXInteractionNotificationHolderTextTypePraise;
            } break;
            default:
                break;
        }
    } else if (self.entryType == XXInteractionNotificationEntryTypePraiseDetail) {
        switch (interactionNotificationType) {
            case XXInteractionNotificationTypePraiseArtical: {
                self.holderTextLabel.text =
                [NSString stringWithFormat:@"%@%@", XXInteractionNotificationPraiseDetailHolderText, XXInteractionNotificationPraiseDetailHolderTextTypeArtical];
            } break;
            case XXInteractionNotificationTypePraisePost: {
                self.holderTextLabel.text =
                [NSString stringWithFormat:@"%@%@", XXInteractionNotificationPraiseDetailHolderText, XXInteractionNotificationPraiseDetailHolderTextTypePost];
            } break;
            case XXInteractionNotificationTypePraiseArticalComment:
            case XXInteractionNotificationTypePraisePostComment:
                self.holderTextLabel.text =
                [NSString stringWithFormat:@"%@%@", XXInteractionNotificationPraiseDetailHolderText, XXInteractionNotificationPraiseDetailHolderTextTypeComment];
                break;
            default:
                break;
        }
    }
}

@end


@implementation XXInteractionNotificationOriginalCommentView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (nil == self) {
        return nil;
    }
    if ([XXInteractionNotificationLayout updateConstraintIfNeeded]) {
        self.size = CGSizeMake(kInteractionNotificationCommentContentWidth5Series, 1);
    } else {
        self.size = CGSizeMake(kInteractionNotificationCommentContentWidth, 1);
    }
    self.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    [self setUpViews];
    return self;
}

#pragma mark - Private methods

- (void)setUpViews {
    UILabel *originalCommentLabel = [UILabel new];
    originalCommentLabel.font = [UIFont systemFontOfSize:kInteractionNotificationOriginalCommentFontSize];
    originalCommentLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    originalCommentLabel.textAlignment = NSTextAlignmentLeft;
    originalCommentLabel.numberOfLines = 2;
    self.originalCommentLabel = originalCommentLabel;
    
    if ([XXInteractionNotificationLayout updateConstraintIfNeeded]) {
        originalCommentLabel.width = 160;
    } else {
        originalCommentLabel.width = kInteractionNotificationOriginalCommentWidth;
    }
    originalCommentLabel.top = kInteractionNotificationOriginalCommentPaddingTop;
    originalCommentLabel.left = kInteractionNotificationOriginalCommentPaddingLeft;
    
    [self addSubview:self.originalCommentLabel];
}

@end


@implementation XXInteractionNotificationPraiseListView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (nil == self) {
        return nil;
    }
    self.size = CGSizeMake(kScreenWidth, kInteractionNotificationProfileHeight);
    return self;
}

#pragma mark - Private methods

- (NSInteger)calculateAvatarViewCountByScreenWidth {
    //    NSInteger avatarViewCount = 0;
    //    switch (currentDevice) {
    //        case 4Series:
    //            avatarViewCount = 4 + 1;
    //            break;
    //        case 5Series:
    //            avatarViewCount = 6 + 1;
    //            break;
    //        case 6Series:
    //            avatarViewCount = 8 + 1;
    //            break;
    //        case PlusSeries:
    //            avatarViewCount = 10 + 1;
    //            break;
    //        default:
    //            avatarViewCount = 8 + 1;
    //            break;
    //    }
    //    return avatarViewCount;
    return 8 + 1;
}

#pragma mark - Getters & Setters

- (void)setPraiseList:(NSArray<NSString *> *)praiseList {
    _praiseList = praiseList;
    if (praiseList == nil || praiseList.count <= 1) {
        return;
    }
    [self removeAllSubviews];
    NSInteger avatarViewCount = [self calculateAvatarViewCountByScreenWidth];
    avatarViewCount = MIN(praiseList.count, avatarViewCount);
    
    CGFloat left = 53;
    NSInteger cnt = avatarViewCount;
    if (avatarViewCount == [self calculateAvatarViewCountByScreenWidth]) {
        cnt -= 1;
    }
    for (int i = 1; i < cnt; ++i) {
        UIImageView *imageView = [UIImageView new];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.size = CGSizeMake(kInteractionNotificationProfileHeight, kInteractionNotificationProfileHeight);
        imageView.layer.cornerRadius = imageView.height * 0.5;
        //        [imageView setImageWithURL:praiseList[i]];
        imageView.backgroundColor = [UIColor grayColor];
        imageView.left = left;
        [self addSubview:imageView];
        left += kInteractionNotificationProfileHeight + 13;
    }
    if (avatarViewCount == [self calculateAvatarViewCountByScreenWidth]) {
        UIImageView *imageView = [UIImageView new];
        imageView.image = [UIImage imageNamed:@"FFFFFF"];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.size = CGSizeMake(kInteractionNotificationProfileHeight, kInteractionNotificationProfileHeight);
        imageView.layer.cornerRadius = imageView.height * 0.5;
        imageView.left = left;
        [self addSubview:imageView];
    }
}

@end


@implementation XXInteractionNotificationView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (nil == self) {
        return nil;
    }
    self.size = CGSizeMake(kScreenWidth, 1);
    [self setUpViews];
    return self;
}

#pragma mark - Private methods

- (void)setUpViews {
    UIView *contentView = [UIView new];
    contentView.backgroundColor = [UIColor whiteColor];
    self.contentView = contentView;
    
    XXInteractionNotificationProfileView *profileView = [XXInteractionNotificationProfileView new];
    self.profileView = profileView;
    
    UILabel *commentTextLabel = [UILabel new];
    commentTextLabel.font = [UIFont systemFontOfSize:kInteractionNotificationCommentContentFontSize];
    commentTextLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    commentTextLabel.textAlignment = NSTextAlignmentLeft;
    commentTextLabel.numberOfLines = 3;
    self.commentTextLabel = commentTextLabel;
    
    UILabel *rightTextLabel = [UILabel new];
    rightTextLabel.hidden = YES;
    rightTextLabel.font = [UIFont systemFontOfSize:kInteractionNotificationRightContentFontSize];
    rightTextLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    rightTextLabel.textAlignment = NSTextAlignmentLeft;
    rightTextLabel.numberOfLines = 4;
    self.rightTextLabel = rightTextLabel;
    
    UILabel *rightRemovedLabel = [UILabel new];
    rightRemovedLabel.hidden = YES;
    rightRemovedLabel.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"];
    rightRemovedLabel.font = [UIFont systemFontOfSize:13];
    rightRemovedLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    rightRemovedLabel.textAlignment = NSTextAlignmentCenter;
    rightRemovedLabel.numberOfLines = 2;
    self.rightRemovedLabel = rightRemovedLabel;
    
    UIImageView *rightImageView = [UIImageView new];
    rightImageView.hidden = YES;
    rightImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.rightImageView = rightImageView;
    
    UIImageView *playIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FFFFFF"]];
    playIconView.hidden = YES;
    playIconView.center = rightImageView.center;
    self.playIconView = playIconView;
    
    XXInteractionNotificationOriginalCommentView *originalCommentView = [XXInteractionNotificationOriginalCommentView new];
    originalCommentView.hidden = YES;
    self.originalCommentView = originalCommentView;
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.font = [UIFont systemFontOfSize:10];
    timeLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel = timeLabel;
    
    XXInteractionNotificationPraiseListView *praiseListView = [XXInteractionNotificationPraiseListView new];
    praiseListView.hidden = YES;
    self.praiseListView = praiseListView;
    
    CALayer *bottomLine = [CALayer layer];
    bottomLine.size = CGSizeMake(self.width, CGFloatFromPixel(1));
    bottomLine.bottom = self.height;
    bottomLine.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"].CGColor;
    self.bottomLine = bottomLine;
    
    contentView.size = CGSizeMake(self.width, 1);
    if ([XXInteractionNotificationLayout updateConstraintIfNeeded]) {
        commentTextLabel.width = kInteractionNotificationCommentContentWidth5Series;
    } else {
        commentTextLabel.width = kInteractionNotificationCommentContentWidth;
    }
    commentTextLabel.left = profileView.nameLabel.left;
    rightTextLabel.width = kInteractionNotificationRightContentWidth;
    rightTextLabel.top = 7;
    rightTextLabel.right = self.width - kInteractionNotificationRightPadding;
    rightImageView.size = CGSizeMake(65, 65);
    rightImageView.top = 7;
    rightImageView.right = rightTextLabel.right;
    rightRemovedLabel.size = CGSizeMake(65, 65);
    rightRemovedLabel.top = 7;
    rightRemovedLabel.right = rightTextLabel.right;
    if ([XXInteractionNotificationLayout updateConstraintIfNeeded]) {
        originalCommentView.width = kInteractionNotificationCommentContentWidth5Series;
    } else {
        originalCommentView.width = kInteractionNotificationCommentContentWidth;
    }
    originalCommentView.left = profileView.nameLabel.left;
    timeLabel.size = CGSizeMake(100, kInteractionNotificationTimeLabelHeight);
    timeLabel.left = commentTextLabel.left;
    
    [self addSubview:self.contentView];
    [self.layer addSublayer:bottomLine];
    [self.contentView addSubview:self.profileView];
    [self.contentView addSubview:self.commentTextLabel];
    [self.contentView addSubview:self.rightTextLabel];
    [self.contentView addSubview:self.rightImageView];
    [self.contentView addSubview:self.rightRemovedLabel];
    [self.contentView addSubview:self.originalCommentView];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.praiseListView];
}

#pragma mark - Common methods

- (NSMutableAttributedString *)textForLineSpacing:(NSString *)text {
    if (text == nil) {
        return nil;
    }
    NSMutableAttributedString *attText = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 3;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [attText addAttributes:@{NSParagraphStyleAttributeName : paragraphStyle} range:NSMakeRange(0, text.length)];
    
    return attText;
}

// XXInteractionNotificationTypeArticalComment
// XXInteractionNotificationTypeArticalCommentReply
- (void)interactionNotificationTypeArticalComment {
    XXInteractionNotificationLayout *layout = self.interactionNotificationLayout;
    XXInteractionNotificationItem *interactionItem = layout.interactionNotificationItem;
    if (1 == interactionItem.topicDel.integerValue) {
        self.rightImageView.hidden = YES;
        self.rightTextLabel.hidden = YES;
        self.rightRemovedLabel.hidden = NO;
        self.rightRemovedLabel.text = XXInteractionNotificationHolderTextTypeArticalRemoved;
    } else if (0 == interactionItem.topicDel.integerValue) {
        self.rightRemovedLabel.hidden = YES;
        if (interactionItem.topicImg != nil && ![interactionItem.topicImg isEqualToString:@""]) {
            self.rightTextLabel.hidden = YES;
            self.rightImageView.hidden = NO;
            //            [self.rightImageView setImageWithURL:interactionItem.topicImg];
            self.rightImageView.backgroundColor = [UIColor blackColor];
        } else {
            self.rightImageView.hidden = YES;
            self.rightTextLabel.hidden = NO;
            NSString *rightText = interactionItem.topicTitle;
            [self.rightTextLabel setAttributedText:[self textForLineSpacing:rightText]];
            self.rightTextLabel.height = layout.rightTextHeight;
        }
    }
}

// XXInteractionNotificationTypeArticalComment
// XXInteractionNotificationTypePostComment
- (void)interactionNotificationTypeComment:(CGFloat)top {
    XXInteractionNotificationLayout *layout = self.interactionNotificationLayout;
    XXInteractionNotificationItem *interactionItem = layout.interactionNotificationItem;
    
    top += kInteractionNotificationCommentContentPaddingTop;
    self.commentTextLabel.top = top;
    self.commentTextLabel.font = [UIFont systemFontOfSize:kInteractionNotificationCommentContentFontSize];
    if (1 == interactionItem.remarkDel.integerValue) {
        self.commentTextLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        self.commentTextLabel.text = XXInteractionNotificationHolderTextTypeOriginalCommentRemoved;
        self.commentTextLabel.height = 21;
        top += 21;
    } else if (0 == interactionItem.remarkDel.integerValue) {
        self.commentTextLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self.commentTextLabel setAttributedText:[self textForLineSpacing:interactionItem.remarkContent]];
        self.commentTextLabel.height = layout.commentTextHeight;
        top += layout.commentTextHeight;
    }
    top += kInteractionNotificationCommentContentPaddingBottom;
    
    self.timeLabel.text = layout.timeString;
    self.timeLabel.top = top;
}

// XXInteractionNotificationTypePostComment
// XXInteractionNotificationTypePostCommentReply
- (void)interactionNotificationTypePostComment {
    XXInteractionNotificationLayout *layout = self.interactionNotificationLayout;
    XXInteractionNotificationItem *interactionItem = layout.interactionNotificationItem;
    
    if (1 == interactionItem.topicDel.integerValue) {
        self.rightImageView.hidden = YES;
        self.rightTextLabel.hidden = YES;
        self.rightRemovedLabel.hidden = NO;
        self.playIconView.hidden = YES;
        self.rightRemovedLabel.text = XXInteractionNotificationHolderTextTypePostRemoved;
    } else if (0 == interactionItem.topicDel.integerValue) {
        self.rightRemovedLabel.hidden = YES;
        if (interactionItem.topicImg != nil && ![interactionItem.topicImg isEqualToString:@""]) {
            self.rightTextLabel.hidden = YES;
            self.rightImageView.hidden = NO;
            //            [self.rightImageView setImageWithURL:interactionItem.topicImg];
            self.rightImageView.backgroundColor = [UIColor blackColor];
            self.playIconView.hidden = !interactionItem.isVideoPost;
        } else {
            self.rightImageView.hidden = YES;
            self.rightTextLabel.hidden = NO;
            self.playIconView.hidden = YES;
            NSString *rightText = @"";
            if (interactionItem.topicTitle != nil && ![interactionItem.topicTitle isEqualToString:@""]) {
                rightText = interactionItem.topicTitle;
            } else {
                rightText = interactionItem.topicContent;
            }
            [self.rightTextLabel setAttributedText:[self textForLineSpacing:rightText]];
            self.rightTextLabel.height = layout.rightTextHeight;
        }
    }
}

// XXInteractionNotificationTypeArticalCommentReply
// XXInteractionNotificationTypePostCommentReply
- (void)interactionNotificationTypeCommentReply:(CGFloat)top {
    XXInteractionNotificationLayout *layout = self.interactionNotificationLayout;
    XXInteractionNotificationItem *interactionItem = layout.interactionNotificationItem;
    
    top += kInteractionNotificationCommentContentPaddingTop;
    self.commentTextLabel.top = top;
    self.commentTextLabel.font = [UIFont systemFontOfSize:kInteractionNotificationReplyContentFontSize];
    if (1 == interactionItem.replyDel.integerValue) {
        self.commentTextLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        self.commentTextLabel.text = XXInteractionNotificationHolderTextTypeCommentRemoved;
        self.commentTextLabel.height = 21;
        top += 21;
    } else if (0 == interactionItem.replyDel.integerValue) {
        self.commentTextLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [self.commentTextLabel setAttributedText:[self textForLineSpacing:interactionItem.replyContent]];
        self.commentTextLabel.height = layout.replyContentHeight;
        top += layout.replyContentHeight;
    }
    
    
    top += 8;
    self.originalCommentView.hidden = NO;
    self.originalCommentView.top = top;
    if (1 == interactionItem.remarkDel.integerValue) {
        self.originalCommentView.originalCommentLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        self.originalCommentView.originalCommentLabel.text = XXInteractionNotificationHolderTextTypeOriginalCommentRemoved;
        self.originalCommentView.originalCommentLabel.height = 19;
        self.originalCommentView.height = 27;
        self.originalCommentView.originalCommentLabel.top = 4;
        top += 27;
    } else if (0 == interactionItem.remarkDel.integerValue) {
        NSString *nickname = interactionItem.parentUserInfo.nickname;
        if (nickname == nil || [nickname isEqualToString:@""]) {
            nickname = @"Yep";
        }
        NSString *text = [NSString stringWithFormat:@"%@:  %@", nickname, interactionItem.remarkContent];
        NSMutableAttributedString *attStr = [self textForLineSpacing:text];
        [attStr addAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithHexString:@"FFFFFF"] }
                        range:NSMakeRange(0, nickname.length + 3)];
        [attStr addAttributes:@{ NSForegroundColorAttributeName : [UIColor colorWithHexString:@"FFFFFF"] }
                        range:NSMakeRange(nickname.length + 3, text.length - nickname.length - 3)];
        [self.originalCommentView.originalCommentLabel setAttributedText:attStr];
        self.originalCommentView.originalCommentLabel.height = layout.originalCommentHeight;
        self.originalCommentView.height = layout.originalCommentHeight + 18;
        self.originalCommentView.originalCommentLabel.top = kInteractionNotificationOriginalCommentPaddingTop;
        top += layout.originalCommentHeight + 18;
    }
    top += kInteractionNotificationCommentContentPaddingBottom;
    self.timeLabel.text = layout.timeString;
    self.timeLabel.top = top;
}

- (void)interactionLayout {
    XXInteractionNotificationLayout *layout = self.interactionNotificationLayout;
    XXInteractionNotificationItem *interactionItem = layout.interactionNotificationItem;
    
    CGFloat top = 0;
    //    [self.profileView.avatarView setImageWithURL:interactionItem.doUserInfo.facePic];
    self.profileView.avatarView.backgroundColor = [UIColor greenColor];
    NSString *nickname = interactionItem.doUserInfo.nickname;
    if (nickname != nil && ![nickname isEqualToString:@""]) {
        self.profileView.nameLabel.text = nickname;
    } else {
        self.profileView.nameLabel.text = @"";
    }
    
    if (layout.interactionNotificationType == XXInteractionNotificationTypePraise) {
        if (interactionItem.praiseList == nil || interactionItem.praiseList.count <= 1) {
            XXInteractionNotificationHolderTextTypePraise = @"1人赞了你";
        } else {
            XXInteractionNotificationHolderTextTypePraise = [NSString stringWithFormat:@"等%@人赞了你", interactionItem.praiseCount];
        }
    }
    self.profileView.entryType = layout.interactionNotificationEntryType;
    self.profileView.interactionNotificationType = layout.interactionNotificationType;
    self.profileView.nameLabel.width = layout.nameWidth;
    [self.profileView updateViewsLayout];
    self.profileView.height = layout.profileHeight;
    self.profileView.top = top;
    top += layout.profileHeight;
    
    self.praiseListView.hidden = YES;
    self.commentTextLabel.hidden = NO;
    self.timeLabel.hidden = NO;
    switch (layout.interactionNotificationType) {
        case XXInteractionNotificationTypeArticalComment: {
            [self interactionNotificationTypeArticalComment];
            [self interactionNotificationTypeComment:top];
            self.originalCommentView.hidden = YES;
        } break;
        case XXInteractionNotificationTypePostComment: {
            [self interactionNotificationTypePostComment];
            [self interactionNotificationTypeComment:top];
            self.originalCommentView.hidden = YES;
        } break;
        case XXInteractionNotificationTypeArticalCommentReply: {
            [self interactionNotificationTypeArticalComment];
            [self interactionNotificationTypeCommentReply:top];
        } break;
        case XXInteractionNotificationTypePostCommentReply: {
            [self interactionNotificationTypePostComment];
            [self interactionNotificationTypeCommentReply:top];
        } break;
        case XXInteractionNotificationTypePraise: {
            self.rightRemovedLabel.hidden = YES;
            self.rightImageView.hidden = YES;
            self.rightTextLabel.hidden = YES;
            self.commentTextLabel.hidden = YES;
            self.originalCommentView.hidden = YES;
            self.timeLabel.hidden = YES;
            self.praiseListView.hidden = NO;
            self.praiseListView.praiseList = interactionItem.praiseList;
            if (interactionItem.praiseList == nil || interactionItem.praiseList.count <= 1) {
                self.praiseListView.hidden = YES;
            } else {
                self.praiseListView.top = top + 8;
            }
        } break;
        default:
            break;
    }
}

- (void)praiseDetailLayout {
    XXInteractionNotificationLayout *layout = self.interactionNotificationLayout;
    XXInteractionNotificationItem *interactionItem = layout.interactionNotificationItem;
    
    CGFloat top = 0;
    //    [self.profileView.avatarView setImageWithURL:interactionItem.praiseUser.facePic];
    self.profileView.avatarView.backgroundColor = [UIColor greenColor];
    NSString *nickname = interactionItem.praiseUser.nickname;
    if (nickname != nil && ![nickname isEqualToString:@""]) {
        self.profileView.nameLabel.text = nickname;
    } else {
        self.profileView.nameLabel.text = @"";
    }
    self.profileView.entryType = layout.interactionNotificationEntryType;
    self.profileView.interactionNotificationType = layout.interactionNotificationType;
    self.profileView.nameLabel.width = layout.nameWidth;
    [self.profileView updateViewsLayout];
    self.profileView.height = layout.profileHeight;
    self.profileView.top = top;
    top += layout.profileHeight;
    
    self.originalCommentView.hidden = YES;
    self.praiseListView.hidden = YES;
    self.timeLabel.hidden = NO;
    switch (layout.interactionNotificationType) {
        case XXInteractionNotificationTypePraiseArtical: {
            [self interactionNotificationTypeArticalComment];
            self.commentTextLabel.hidden = YES;
            self.rightImageView.top = -3;
            self.rightRemovedLabel.top = -3;
        } break;
        case XXInteractionNotificationTypePraisePost: {
            [self interactionNotificationTypePostComment];
            self.commentTextLabel.hidden = YES;
            self.rightImageView.top = -3;
            self.rightRemovedLabel.top = -3;
        } break;
        case XXInteractionNotificationTypePraiseArticalComment: {
            [self interactionNotificationTypeArticalComment];
            [self interactionNotificationTypeComment:top];
            self.commentTextLabel.hidden = NO;
            self.rightImageView.top = 7;
            self.rightRemovedLabel.top = 7;
            return;
        } break;
        case XXInteractionNotificationTypePraisePostComment: {
            [self interactionNotificationTypePostComment];
            [self interactionNotificationTypeComment:top];
            self.commentTextLabel.hidden = NO;
            self.rightImageView.top = 7;
            self.rightRemovedLabel.top = 7;
            return;
        } break;
        default:
            break;
    }
    
    top += kInteractionNotificationNoCommentContentPaddingBottom;
    self.timeLabel.text = layout.timeString;
    self.timeLabel.top = top;
}

#pragma mark - Getters & Setters

- (void)setInteractionNotificationLayout:(XXInteractionNotificationLayout *)layout {
    _interactionNotificationLayout = layout;
    
    self.height = layout.height;
    self.bottomLine.bottom = layout.height;
    self.contentView.top = layout.marginTop;
    self.contentView.height = layout.height - layout.marginTop - layout.marginBottom;
    
    switch (layout.interactionNotificationEntryType) {
        case XXInteractionNotificationEntryTypeMain:
            [self interactionLayout];
            break;
        case XXInteractionNotificationEntryTypePraiseDetail:
            [self praiseDetailLayout];
            break;
        default:
            break;
    }
}

@end


@implementation XXInteractionNotificationCell

#pragma mark - Lifecycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (nil == self) {
        return nil;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setUpViews];
    return self;
}

- (void)setInteractionNotificationLayout:(XXInteractionNotificationLayout *)layout {
    if (![layout isMemberOfClass:[XXInteractionNotificationLayout class]]) {
        return;
    }
    self.height = layout.height;
    self.contentView.height = layout.height;
    self.interactionNotificationView.interactionNotificationLayout = layout;
}

#pragma mark - Private methods

- (void)setUpViews {
    XXInteractionNotificationView *interactionView = [XXInteractionNotificationView new];
    self.interactionNotificationView = interactionView;
    [self.contentView addSubview:self.interactionNotificationView];
}

#pragma mark - Public methods

+ (NSString *)cellId {
    return @"XXInteractionNotificationCell";
}

@end
