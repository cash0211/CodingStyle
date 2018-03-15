//
//  XXRecommendCell.m
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXRecommendCell.h"
#import "XXRecommendModel.h"

#import "UIColor+YYAdd.h"
#import "UIView+YYAdd.h"

static NSString *const XXRecommendPlaceHolderTextTypeHot = @"HOT";
static NSString *const XXRecommendPlaceHolderTextTypeNew = @"NEW";

@interface XXRecommendCell()
@property (nonatomic, strong) UIImageView *descriptionImageView;
@property (nonatomic, strong) UILabel      *descriptionLabel;
@property (nonatomic, strong) UIImageView *tagImageView;
@end

@implementation XXRecommendCell

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (nil == self) {
        return nil;
    }
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self setUpViews];
    return self;
}

- (void)setUpViews {
    UIImageView *descImageView = [UIImageView new];
    self.descriptionImageView = descImageView;
    
    UILabel *descLabel = [UILabel new];
    descLabel.font = [UIFont systemFontOfSize:14];
    descLabel.textColor = [UIColor colorWithHexString:@"323232"];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 1;
    self.descriptionLabel = descLabel;
    
    UIImageView *tagImageView = [UIImageView new];
    tagImageView.hidden = YES;
    self.tagImageView = tagImageView;
    
    descImageView.size = CGSizeMake(33, 33);
    descImageView.top = 12;
    descImageView.centerX = self.contentView.centerX;
    descLabel.size = CGSizeMake(self.contentView.width - 6, 20);
    descLabel.top = descImageView.bottom + 6;
    descLabel.left = 3;
    tagImageView.size = CGSizeMake(20, 10);
    tagImageView.top  = 13;
    tagImageView.left = descImageView.left + 22;
    tagImageView.layer.cornerRadius = tagImageView.height / 2;
    
    [self.contentView addSubview:self.descriptionImageView];
    [self.contentView addSubview:self.descriptionLabel];
    [self.contentView addSubview:self.tagImageView];
}

#pragma mark - Public method

+ (NSString *)cellId {
    return @"XXRecommendCell";
}

- (void)setItem:(XXRecommendItem *)item {
    _item = item;
    //    [self.descriptionImageView updateWithImageAtURL:item.img];
    self.descriptionImageView.backgroundColor = [UIColor orangeColor];
    self.descriptionLabel.text = item.title;
    if ([item.tags isEqualToString:XXRecommendPlaceHolderTextTypeHot]) {
        self.tagImageView.hidden = NO;
        self.tagImageView.image = [UIImage imageNamed:@"FFFFFF"];
    } else if ([item.tags isEqualToString:XXRecommendPlaceHolderTextTypeNew]) {
        self.tagImageView.hidden = NO;
        self.tagImageView.image = [UIImage imageNamed:@"FFFFFF"];
    } else {
        self.tagImageView.hidden = YES;
    }
}

@end

@implementation XXRecommendPlaceHolderCell
+ (NSString *)cellId {
    return @"XXRecommendPlaceHolderCell";
}
@end
