//
//  XXInteractionNotificationLayout.m
//  XXInteractionNotificationDemo
//
//  Created by cash on 23/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXInteractionNotificationLayout.h"
#import "XXInteractionNotification.h"

@implementation XXInteractionNotificationLayout

#pragma mark - Lifecycle

- (instancetype)initWithInteractionNotificationItem:(XXInteractionNotificationItem *)interactionNotificationItem
                                               type:(XXInteractionNotificationType)interactionNotificationType
                                          entryType:(XXInteractionNotificationEntryType)entryType {
    if (!interactionNotificationItem) {
        return nil;
    }
    self = [super init];
    self.interactionNotificationItem = interactionNotificationItem;
    self.interactionNotificationType = interactionNotificationType;
    self.interactionNotificationEntryType = entryType;
    switch (entryType) {
        case XXInteractionNotificationEntryTypeMain:
            [self commentLayout];
            break;
        case XXInteractionNotificationEntryTypePraiseDetail:
            [self praiseLayout];
            break;
        default:
            break;
    }
    return self;
}

- (void)commentLayout {
    self.marginTop = kInteractionNotificationTopMargin;
    self.profileHeight = kInteractionNotificationProfileHeight;
    self.nameWidth = 0;
    self.commentTextHeight = 0;
    self.rightTextHeight = 0;
    self.originalCommentHeight = 0;
    self.replyContentHeight = 0;
    self.praiseListHeight = kInteractionNotificationProfileHeight;
    self.timeTextHeight = kInteractionNotificationTimeLabelHeight;
    self.marginBottom = kInteractionNotificationBottomMargin;
    
    self.height = 0;
    self.height += self.marginTop;
    self.height += self.profileHeight;
    
    [self layoutNameText:self.interactionNotificationItem.doUserInfo.nickname];
    if (self.interactionNotificationType == XXInteractionNotificationTypePraise) {
        if (self.interactionNotificationItem.praiseList == nil
            || self.interactionNotificationItem.praiseList.count <= 1) {
            self.height += self.marginTop;
            return;
        }
        self.height += 8;
        self.height += self.praiseListHeight;
        self.height += 21;
        return;
    }
    
    [self layoutRightText];
    [self setUpTime];
    if (self.interactionNotificationType == XXInteractionNotificationTypeArticalCommentReply
        || self.interactionNotificationType == XXInteractionNotificationTypePostCommentReply) {
        
        if (1 == self.interactionNotificationItem.replyDel.integerValue) {
            self.replyContentHeight = 21;
        } else {
            [self layoutReplyContent];
        }
        self.height += self.replyContentHeight;
        self.height += 8;
        
        if (1 == self.interactionNotificationItem.remarkDel.integerValue) {
            self.originalCommentHeight = 19;
            self.height += 8;
        } else {
            [self layoutOriginalComment];
            self.height += 18;
        }
        self.height += self.originalCommentHeight;
        self.height += kInteractionNotificationCommentContentPaddingTop;
        self.height += kInteractionNotificationCommentContentPaddingBottom;
    } else {
        if (1 == self.interactionNotificationItem.remarkDel.integerValue) {
            self.commentTextHeight = 21;
        } else {
            [self layoutCommentText];
        }
        self.height += kInteractionNotificationCommentContentPaddingTop;
        self.height += self.commentTextHeight;
        self.height += kInteractionNotificationCommentContentPaddingBottom;
    }
    
    self.height += self.timeTextHeight;
    self.height += self.marginBottom;
}

- (void)praiseLayout {
    self.marginTop = kInteractionNotificationTopMargin;
    self.profileHeight = kInteractionNotificationProfileHeight;
    self.nameWidth = 0;
    self.commentTextHeight = 0;
    self.rightTextHeight = 0;
    self.timeTextHeight = kInteractionNotificationTimeLabelHeight;
    self.marginBottom = kInteractionNotificationBottomMargin;
    
    self.height = 0;
    self.height += self.marginTop;
    self.height += self.profileHeight;
    
    [self layoutNameText:self.interactionNotificationItem.praiseUser.nickname];
    [self layoutRightText];
    [self setUpTime];
    
    switch (self.interactionNotificationType) {
        case XXInteractionNotificationTypePraiseArticalComment:
        case XXInteractionNotificationTypePraisePostComment: {
            if (1 == self.interactionNotificationItem.remarkDel.integerValue) {
                self.commentTextHeight = 21;
            } else {
                [self layoutCommentText];
            }
            self.height += kInteractionNotificationCommentContentPaddingTop;
            self.height += self.commentTextHeight;
            self.height += kInteractionNotificationCommentContentPaddingBottom;
        } break;
        default: {
            self.height += kInteractionNotificationNoCommentContentPaddingBottom;
        } break;
    }
    self.height += self.timeTextHeight;
    self.height += self.marginBottom;
}

#pragma mark - Common methods

- (void)layoutNameText:(NSString *)text {
    self.nameWidth = 0;
    
    CGFloat curNameWidth = [self calculateContainerWidthWithHeight:20 lines:1 fontSize:kInteractionNotificationNameFontSize text:text];
    
    if ([XXInteractionNotificationLayout updateConstraintIfNeeded] && curNameWidth > 70) {
        self.nameWidth = 70;
        return;
    }
    if (text.length > 7 && curNameWidth > 100) {
        self.nameWidth = 100;
        return;
    }
    
    self.nameWidth = curNameWidth;
}

- (void)layoutCommentText {
    self.commentTextHeight = 0;
    
    self.commentTextHeight = [self calculateContainerHeightWithWidth:[XXInteractionNotificationLayout getContainerWidth] lines:3 fontSize:kInteractionNotificationCommentContentFontSize text:self.interactionNotificationItem.remarkContent];
}

- (void)layoutRightText {
    self.rightTextHeight = 0;
    
    NSString *textForHeight = @"";
    if (self.interactionNotificationItem.topicTitle != nil && ![self.interactionNotificationItem.topicTitle isEqualToString:@""]) {
        textForHeight = self.interactionNotificationItem.topicTitle;
    } else {
        textForHeight = self.interactionNotificationItem.topicContent;
    }
    
    self.rightTextHeight = [self calculateContainerHeightWithWidth:kInteractionNotificationRightContentWidth lines:4 fontSize:kInteractionNotificationRightContentFontSize text:textForHeight];
}

- (void)layoutOriginalComment {
    self.originalCommentHeight = 0;
    
    NSString *textForHeight = [NSString stringWithFormat:@"%@：%@", self.interactionNotificationItem.parentUserInfo.nickname, self.interactionNotificationItem.remarkContent];
    
    self.originalCommentHeight = [self calculateContainerHeightWithWidth:[XXInteractionNotificationLayout getContainerWidth] lines:2 fontSize:kInteractionNotificationOriginalCommentFontSize text:textForHeight];
}

- (void)layoutReplyContent {
    self.replyContentHeight = 0;
    
    self.replyContentHeight = [self calculateContainerHeightWithWidth:[XXInteractionNotificationLayout getContainerWidth] lines:3 fontSize:kInteractionNotificationReplyContentFontSize text:self.interactionNotificationItem.replyContent];
}

+ (CGFloat)getContainerWidth {
    if ([self updateConstraintIfNeeded]) {
        return kInteractionNotificationCommentContentWidth5Series;
    } else {
        return kInteractionNotificationCommentContentWidth;
    }
}

+ (BOOL)updateConstraintIfNeeded {
    return CGSizeEqualToSize([UIScreen mainScreen].bounds.size, CGSizeMake(320, 568));
}

- (CGFloat)calculateContainerHeightWithWidth:(CGFloat)width lines:(NSInteger)lines fontSize:(CGFloat)fontSize text:(NSString *)text {
    return [self calculateContainerSizeWithConstraint:width isWidth:YES lines:lines fontSize:fontSize text:text].height;
}

- (CGFloat)calculateContainerWidthWithHeight:(CGFloat)height lines:(NSInteger)lines fontSize:(CGFloat)fontSize text:(NSString *)text {
    return [self calculateContainerSizeWithConstraint:height isWidth:NO lines:lines fontSize:fontSize text:text].width;
}

- (CGSize)calculateContainerSizeWithConstraint:(CGFloat)constraint isWidth:(BOOL)isWidth lines:(NSInteger)lines fontSize:(CGFloat)fontSize text:(NSString *)text {
    if (text == nil) { return CGSizeZero; }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, constraint, CGFLOAT_MAX)];
    if (!isWidth) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, constraint)];
    }
    label.numberOfLines = lines;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 3;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [label setAttributedText:[[NSAttributedString alloc]
                              initWithString:text
                              attributes:@{ NSParagraphStyleAttributeName : paragraphStyle,
                                            NSFontAttributeName           : [UIFont systemFontOfSize:fontSize]
                                            }]];
    [label sizeToFit];
    return label.bounds.size;
}

- (void)setUpTime {
    // time format & more
    self.timeString = self.interactionNotificationItem.createTime;
}

@end
