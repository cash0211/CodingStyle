//
//  XXMyFollowAndHotCircleCell.m
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXMyFollowAndHotCircleCell.h"
#import "XXHotModel.h"
#import "UIColor+YYAdd.h"
#import "UIView+YYAdd.h"

@interface XXMyFollowAndHotCircleCell()
@property (nonatomic, strong) UIImageView  *descriptionImageView;
@property (nonatomic, strong) UILabel      *descriptionLabel;
@end

@implementation XXMyFollowAndHotCircleCell

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (nil == self) {
        return nil;
    }
    self.contentView.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    self.contentView.layer.borderColor = [UIColor colorWithHexString:@"FFFFFF"].CGColor;
    self.contentView.layer.cornerRadius = 3;
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self setUpViews];
    return self;
}

- (void)setUpViews {
    UIImageView *descImageView = [UIImageView new];
    self.descriptionImageView = descImageView;
    
    UILabel *descLabel = [UILabel new];
    descLabel.font = [UIFont systemFontOfSize:14];
    descLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 1;
    self.descriptionLabel = descLabel;
    
    descLabel.size = CGSizeMake(self.contentView.width - 10, 20);
    descLabel.bottom = self.contentView.bottom - 11;
    descLabel.left = 5;
    descImageView.size = CGSizeMake(40, 40);
    descImageView.bottom = descLabel.top - 7;
    descImageView.centerX = self.contentView.centerX;
    
    [self.contentView addSubview:self.descriptionImageView];
    [self.contentView addSubview:self.descriptionLabel];
}

#pragma mark - Public method

+ (NSString *)cellId {
    return @"XXMyFollowAndHotCircleCell";
}

- (void)setItem:(XXHotModel *)item {
    _item = item;
    //    [self.descriptionImageView updateWithImageAtURL:item.logo];
    self.descriptionImageView.backgroundColor = [UIColor blackColor];
    self.descriptionLabel.text = item.name;
}

@end

@implementation XXMyFollowAndHotCircleMoreCell

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (nil == self) {
        return nil;
    }
    self.contentView.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    self.contentView.layer.borderColor = [UIColor colorWithHexString:@"FFFFFF"].CGColor;
    self.contentView.layer.cornerRadius = 3;
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView *descImageView = [UIImageView new];
    descImageView.image = [UIImage imageNamed:@"FFFFFF"];
    UILabel *descLabel = [UILabel new];
    descLabel.font = [UIFont systemFontOfSize:14];
    descLabel.textColor = [UIColor colorWithHexString:@"FFFFFF"];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.numberOfLines = 1;
    descLabel.text = @"FFFFFF";
    descLabel.size = CGSizeMake(self.contentView.width - 10, 20);
    descLabel.bottom = self.contentView.bottom - 11;
    descLabel.left = 5;
    descImageView.size = CGSizeMake(40, 40);
    descImageView.bottom = descLabel.top - 7;
    descImageView.centerX = self.contentView.centerX;
    descImageView.layer.cornerRadius = descImageView.height / 2;
    [self.contentView addSubview:descImageView];
    [self.contentView addSubview:descLabel];
    return self;
}

+ (NSString *)cellId {
    return @"XXMyFollowAndHotCircleMoreCell";
}

@end
