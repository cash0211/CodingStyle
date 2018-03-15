//
//  XXMyFollowAndHotCircleInnerTopView.m
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXMyFollowAndHotCircleInnerTopView.h"

#import "YYCGUtilities.h"
#import "UIColor+YYAdd.h"
#import "UIView+YYAdd.h"
#import "UIControl+YYAdd.h"
#import "CALayer+YYAdd.h"

static const NSInteger kViewHeight = 0;

@interface XXMyFollowAndHotCircleInnerTopView()
@property (nonatomic, strong) UILabel         *myFollowLabel;
@property (nonatomic, strong) UILabel         *hotCircleLabel;
@property (nonatomic, strong) UILabel         *allCircleLabel;
@property (nonatomic, strong) UIButton        *myFollowButton;
@property (nonatomic, strong) UIButton        *hotCircleButton;
@property (nonatomic, strong) UIButton        *allCircleButton;
@property (nonatomic, strong) CALayer         *middleLine;
@property (nonatomic, strong) CALayer         *bottomLayer;
@property (nonatomic, assign) XXInnerType      type;
@end

@implementation XXMyFollowAndHotCircleInnerTopView

#pragma mark - Lifecycle

- (instancetype)initWithIsLogin:(BOOL)isLogin {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kViewHeight)];
    if (nil == self) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    self.type = XXInnerTypeMyFollow;
    [self setUpViews];
    if (!isLogin) {
        [self updateLayout];
    }
    return self;
}

- (void)setUpViews {
    UILabel *myFollowLabel = [UILabel new];
    myFollowLabel.font = [UIFont systemFontOfSize:16];
    myFollowLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    myFollowLabel.textAlignment = NSTextAlignmentLeft;
    myFollowLabel.numberOfLines = 1;
    self.myFollowLabel = myFollowLabel;
    UIButton *myFollowButton = [UIButton new];
    self.myFollowButton = myFollowButton;
    
    CALayer *middleLine = [CALayer layer];
    middleLine.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"].CGColor;
    self.middleLine = middleLine;
    
    UILabel *hotCircleLabel = [UILabel new];
    hotCircleLabel.font = [UIFont systemFontOfSize:16];
    hotCircleLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    hotCircleLabel.textAlignment = NSTextAlignmentLeft;
    hotCircleLabel.numberOfLines = 1;
    self.hotCircleLabel = hotCircleLabel;
    UIButton *hotCircleButton = [UIButton new];
    self.hotCircleButton = hotCircleButton;
    
    UILabel *allCircleLabel = [UILabel new];
    allCircleLabel.font = [UIFont systemFontOfSize:12];
    allCircleLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    allCircleLabel.textAlignment = NSTextAlignmentLeft;
    allCircleLabel.numberOfLines = 1;
    self.allCircleLabel = allCircleLabel;
    UIButton *allCircleButton = [UIButton new];
    self.allCircleButton = allCircleButton;
    
    CALayer *bottomLayer = [CALayer layer];
    bottomLayer.backgroundColor = [UIColor colorWithHexString:@"FFFFFF"].CGColor;
    bottomLayer.cornerRadius = 1 / [UIScreen mainScreen].scale;
    self.bottomLayer = bottomLayer;
    
    myFollowLabel.text = @"FFFFFF";
    myFollowLabel.size = CGSizeMake(66, 23);
    myFollowButton.size = myFollowLabel.size;
    myFollowButton.bottom = kViewHeight - 3;
    myFollowButton.left = 12;
    
    middleLine.size = CGSizeMake(1 / [UIScreen mainScreen].scale, 14);
    middleLine.centerY = myFollowButton.centerY;
    middleLine.left = myFollowButton.right + 13;
    
    hotCircleLabel.text = @"FFFFFF";
    hotCircleLabel.size = myFollowLabel.size;
    hotCircleButton.size = hotCircleLabel.size;
    hotCircleButton.bottom = myFollowButton.bottom;
    hotCircleButton.left = middleLine.right + 13;
    
    NSTextAttachment *attachment = [NSTextAttachment new];
    attachment.image = [UIImage imageNamed:@"FFFFFF"];
    NSAttributedString *imgAttrString = [NSAttributedString attributedStringWithAttachment:attachment];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:@"FFFFFF"];
    [attStr appendAttributedString:imgAttrString];
    allCircleLabel.attributedText = attStr;
    allCircleLabel.size = CGSizeMake(70, self.height);
    allCircleButton.size = allCircleLabel.size;
    allCircleButton.right = self.width;
    
    bottomLayer.size = CGSizeMake(15, 2);
    bottomLayer.centerX = myFollowButton.centerX;
    bottomLayer.bottom = kViewHeight;
    
    __weak __typeof(self)weakSelf = self;
    [myFollowButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.type == XXInnerTypeMyFollow) {
            return;
        }
        strongSelf.type = XXInnerTypeMyFollow;
        strongSelf.myFollowLabel.font =  [UIFont systemFontOfSize:16];
        strongSelf.myFollowLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        strongSelf.hotCircleLabel.font = [UIFont systemFontOfSize:16];
        strongSelf.hotCircleLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [UIView animateWithDuration:0.25 animations:^{
            strongSelf.bottomLayer.centerX = strongSelf.myFollowButton.centerX;
        }];
        if ([strongSelf.delegate respondsToSelector:@selector(myFollowAndHotCircleInnerTopViewDidTap:)]) {
            [strongSelf.delegate myFollowAndHotCircleInnerTopViewDidTap:XXInnerTypeMyFollow];
        }
    }];
    [hotCircleButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (strongSelf.type == XXInnerTypeHotCircle) {
            return;
        }
        strongSelf.type = XXInnerTypeHotCircle;
        strongSelf.hotCircleLabel.font =  [UIFont systemFontOfSize:16];
        strongSelf.hotCircleLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        strongSelf.myFollowLabel.font = [UIFont systemFontOfSize:16];
        strongSelf.myFollowLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
        [UIView animateWithDuration:0.25 animations:^{
            strongSelf.bottomLayer.centerX = strongSelf.hotCircleButton.centerX;
        }];
        if ([strongSelf.delegate respondsToSelector:@selector(myFollowAndHotCircleInnerTopViewDidTap:)]) {
            [strongSelf.delegate myFollowAndHotCircleInnerTopViewDidTap:XXInnerTypeHotCircle];
        }
    }];
    [allCircleButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if ([strongSelf.delegate respondsToSelector:@selector(myFollowAndHotCircleInnerTopViewDidTap:)]) {
            [strongSelf.delegate myFollowAndHotCircleInnerTopViewDidTap:XXInnerTypeAllCircle];
        }
    }];
    
    [self.myFollowButton  addSubview:self.myFollowLabel];
    [self.hotCircleButton addSubview:self.hotCircleLabel];
    [self.allCircleButton addSubview:self.allCircleLabel];
    [self addSubview:self.myFollowButton];
    [self addSubview:self.hotCircleButton];
    [self addSubview:self.allCircleButton];
    [self.layer addSublayer:self.middleLine];
    [self.layer addSublayer:self.bottomLayer];
}

- (void)updateLayout {
    self.type = XXInnerTypeNone;
    self.myFollowButton.hidden = YES;
    self.hotCircleLabel.font = [UIFont systemFontOfSize:16];
    self.hotCircleLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    self.hotCircleButton.left = 12;
    self.hotCircleButton.userInteractionEnabled = NO;
    self.middleLine.hidden = YES;
    self.bottomLayer.hidden = YES;
}

@end
