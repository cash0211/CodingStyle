//
//  XXBannerView.m
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXBannerView.h"
#import "XXBannerModel.h"

#import "YYCGUtilities.h"
#import "UIView+YYAdd.h"
#import "CALayer+YYAdd.h"
#import "UIColor+YYAdd.h"
#import "YYWeakProxy.h"

static const NSInteger kViewHeight      = 0;
static const NSInteger kImageViewCount  = 0;
static const NSInteger kDescLabelHeight = 0;
static const NSInteger kDescLabelLeft   = 0;
static const NSInteger kBgMaskHeight    = 0;

@interface XXBannerView() <UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView                 *imageScrollView;
@property (nonatomic, strong) UIImageView                  *leftImageView;
@property (nonatomic, strong) UIImageView                  *centerImageView;
@property (nonatomic, strong) UIImageView                  *rightImageView;
@property (nonatomic, strong) UILabel                      *leftDescriptionLabel;
@property (nonatomic, strong) UILabel                      *centerDescriptionLabel;
@property (nonatomic, strong) UILabel                      *rightDescriptionLabel;
@property (nonatomic, strong) UIImageView                  *leftBackgroundImageView;
@property (nonatomic, strong) UIImageView                  *centerBackgroundImageView;
@property (nonatomic, strong) UIImageView                  *rightBackgroundImageView;
@property (nonatomic, strong) UIView                       *pageControl;

@property (nonatomic, copy)   NSArray<XXBannerItem *>      *items;
@property (nonatomic, assign) NSInteger                     itemTotalPageCount;
@property (nonatomic, assign) NSInteger                     currentPageIndex;
@property (nonatomic, strong) NSTimer                      *backupTimer;
@end

@implementation XXBannerView

#pragma mark - Lifecycle

- (instancetype)initWithItems:(NSArray<XXBannerItem *> *)items {
    self = [super initWithFrame:CGRectMake(0, 0, kScreenWidth, kViewHeight)];
    if (nil == self) {
        return nil;
    }
    if (nil == items || 0 == items.count) {
        return nil;
    }
    self.backgroundColor = [UIColor whiteColor];
    self.items = items.copy;
    self.currentPageIndex = NSNotFound;
    self.itemTotalPageCount = items.count;
    [self setUpViews];
    return self;
}

#pragma mark - Private methods

- (void)setUpViews {
    UIScrollView *imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.width, kViewHeight)];
    imageScrollView.contentSize = CGSizeMake(self.width * kImageViewCount, kViewHeight);
    imageScrollView.contentOffset = CGPointMake(self.width, 0);
    imageScrollView.pagingEnabled = YES;
    imageScrollView.delegate = self;
    imageScrollView.showsHorizontalScrollIndicator = NO;
    self.imageScrollView = imageScrollView;
    
    self.leftImageView             = [self imageViewFactoryWithOffsetX:0];
    self.leftBackgroundImageView   = [self bgMaskFactoryWithOffsetX:0];
    self.leftDescriptionLabel      = [self labelFactoryWithOffsetX:0];
    self.centerImageView           = [self imageViewFactoryWithOffsetX:self.width];
    self.centerBackgroundImageView = [self bgMaskFactoryWithOffsetX:self.width];
    self.centerDescriptionLabel    = [self labelFactoryWithOffsetX:self.width];
    self.rightImageView            = [self imageViewFactoryWithOffsetX:self.width * 2];
    self.rightBackgroundImageView  = [self bgMaskFactoryWithOffsetX:self.width * 2];
    self.rightDescriptionLabel     = [self labelFactoryWithOffsetX:self.width * 2];
    
    UIView *pageControl = [UIView new];
    pageControl.tag = 0;
    pageControl.size = CGSizeMake(self.width, 4);
    pageControl.bottom = kViewHeight - 10;
    pageControl.userInteractionEnabled = NO;
    self.pageControl = pageControl;
    
    [self addSubview:self.imageScrollView];
    [self.imageScrollView addSubview:self.leftImageView];
    [self.imageScrollView addSubview:self.centerImageView];
    [self.imageScrollView addSubview:self.rightImageView];
    [self.imageScrollView addSubview:self.leftBackgroundImageView];
    [self.imageScrollView addSubview:self.centerBackgroundImageView];
    [self.imageScrollView addSubview:self.rightBackgroundImageView];
    [self.imageScrollView addSubview:self.leftDescriptionLabel];
    [self.imageScrollView addSubview:self.centerDescriptionLabel];
    [self.imageScrollView addSubview:self.rightDescriptionLabel];
    [self addSubview:self.pageControl];
    
    if (1 == self.itemTotalPageCount) {
        imageScrollView.contentSize = CGSizeMake(self.width, kViewHeight);
        imageScrollView.contentOffset = CGPointMake(0, 0);
        imageScrollView.pagingEnabled = NO;
        self.centerImageView.left = 0;
        self.centerDescriptionLabel.left = kDescLabelLeft;
        self.centerBackgroundImageView.left = 0;
        [self.leftImageView removeFromSuperview];
        [self.rightImageView removeFromSuperview];
        [self.leftDescriptionLabel removeFromSuperview];
        [self.rightDescriptionLabel removeFromSuperview];
        [self.leftBackgroundImageView removeFromSuperview];
        [self.rightBackgroundImageView removeFromSuperview];
        [self.pageControl removeFromSuperview];
        [self setUpData:0];
    } else {
        [self scrollViewDidEndDecelerating:self.imageScrollView];
        [self startBackupTimer];
    }
}

- (void)setUpData:(NSInteger)page {
    NSInteger preIndex = (page - 1 + self.itemTotalPageCount) % self.itemTotalPageCount;
    NSInteger nextIndex = (page + 1) % self.itemTotalPageCount;
    
    CGFloat leftWidth   = [self calculateContainerWidthWithText:self.items[preIndex].title];
    CGFloat centerWidth = [self calculateContainerWidthWithText:self.items[page].title];
    CGFloat rightWidth  = [self calculateContainerWidthWithText:self.items[nextIndex].title];
    if (0 == self.pageControl.tag) {
        leftWidth = 0;
        rightWidth = 0;
        if (centerWidth > (self.width - kDescLabelLeft * 2)) {
            centerWidth = self.width - kDescLabelLeft * 2;
        }
    } else if (self.pageControl.tag > 0) {
        CGFloat maxTextCount = self.pageControl.tag - kDescLabelLeft * 2;
        if (leftWidth > maxTextCount) {
            leftWidth = maxTextCount;
        }
        if (centerWidth > maxTextCount) {
            centerWidth = maxTextCount;
        }
        if (rightWidth > maxTextCount) {
            rightWidth = maxTextCount;
        }
    }
    
    //    [self.leftImageView setImageWithURL:self.items[preIndex].img];
    self.leftImageView.backgroundColor = [UIColor redColor];
    self.leftImageView.tag = preIndex;
    if (self.items[preIndex].isShowFlag == YES) {
        self.leftDescriptionLabel.hidden = NO;
        self.leftDescriptionLabel.text = self.items[preIndex].title;
        self.leftDescriptionLabel.width = leftWidth;
    } else {
        self.leftDescriptionLabel.hidden = YES;
    }
    
    //    [self.centerImageView setImageWithURL:self.items[page].img];
    self.centerImageView.backgroundColor = [UIColor greenColor];
    self.centerImageView.tag = page;
    if (self.items[page].isShowFlag == YES) {
        self.centerDescriptionLabel.hidden = NO;
        self.centerDescriptionLabel.text = self.items[page].title;
        self.centerDescriptionLabel.width = centerWidth;
    } else {
        self.centerDescriptionLabel.hidden = YES;
    }
    
    //    [self.rightImageView setImageWithURL:self.items[nextIndex].img];
    self.rightImageView.backgroundColor = [UIColor blueColor];
    self.rightImageView.tag = nextIndex;
    if (self.items[nextIndex].isShowFlag == YES) {
        self.rightDescriptionLabel.hidden = NO;
        self.rightDescriptionLabel.text = self.items[nextIndex].title;
        self.rightDescriptionLabel.width = rightWidth;
    } else {
        self.rightDescriptionLabel.hidden = YES;
    }
}

- (NSInteger)calculateCurrentPageIndex:(UIScrollView *)scrollView  {
    if (self.currentPageIndex == NSNotFound) {
        return 0;
    }
    
    CGFloat contentOffsetX = scrollView.contentOffset.x;
    NSInteger currentPageIndex = self.currentPageIndex;
    if (contentOffsetX < self.width) {
        currentPageIndex = (currentPageIndex - 1 + _itemTotalPageCount) % _itemTotalPageCount;
    } else if (contentOffsetX > self.width) {
        currentPageIndex = (currentPageIndex + 1) % _itemTotalPageCount;
    }
    
    return currentPageIndex;
}

- (CGFloat)calculateContainerWidthWithText:(NSString *)text {
    if (text == nil) {
        return 0;
    }
    return [self calculateContainerSizeWithConstraint:kDescLabelHeight lines:1 fontSize:16 text:text].width;
}

- (CGSize)calculateContainerSizeWithConstraint:(CGFloat)constraint lines:(NSInteger)lines fontSize:(CGFloat)fontSize text:(NSString *)text {
    if (text == nil) { return CGSizeZero; }
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, constraint)];
    label.numberOfLines = lines;
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    [label setAttributedText:[[NSAttributedString alloc]
                              initWithString:text
                              attributes:@{ NSParagraphStyleAttributeName : paragraphStyle,
                                            NSFontAttributeName           : [UIFont systemFontOfSize:fontSize]
                                            }]];
    [label sizeToFit];
    return label.bounds.size;
}

- (UIImageView *)imageViewFactoryWithOffsetX:(CGFloat)x {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, self.width, kViewHeight)];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(delegateCallback:)];
    [imageView addGestureRecognizer:tap];
    return imageView;
}

- (void)delegateCallback:(UITapGestureRecognizer *)tap {
    if ([tap.view isKindOfClass:[UIImageView class]]) {
        if ([self.delegate respondsToSelector:@selector(bannerImageViewDidTaped:)]) {
            XXBannerItem *item = self.items[tap.view.tag];
            item.index = tap.view.tag;
            [self.delegate bannerImageViewDidTaped:item];
        }
    }
}

- (UIImageView *)bgMaskFactoryWithOffsetX:(CGFloat)x {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, self.width, kBgMaskHeight)];
    imageView.image = [UIImage imageNamed:@"XX_bgmask"];
    imageView.bottom = kViewHeight;
    return imageView;
}

- (UILabel *)labelFactoryWithOffsetX:(CGFloat)x {
    UILabel *descLabel = [UILabel new];
    descLabel.height = kDescLabelHeight;
    descLabel.bottom = kViewHeight - 6;
    descLabel.left = x + kDescLabelLeft;
    descLabel.font = [UIFont systemFontOfSize:16];
    descLabel.textColor = [UIColor whiteColor];
    descLabel.textAlignment = NSTextAlignmentLeft;
    descLabel.numberOfLines = 1;
    return descLabel;
}

- (void)startBackupTimer {
    if (self.itemTotalPageCount <= 1) return;
    [self endBackupTimer];
    if (self.backupTimer == nil) {
        self.backupTimer = [NSTimer scheduledTimerWithTimeInterval:4 target:[YYWeakProxy proxyWithTarget:self] selector:@selector(backupTimerTrigger) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:self.backupTimer forMode:NSRunLoopCommonModes];
    }
}

- (void)backupTimerTrigger {
    [UIView animateWithDuration:0.2 animations:^{
        self.imageScrollView.contentOffset = CGPointMake(self.width * 2, 0);
    } completion:^(BOOL finished) {
        [self scrollViewDidEndDecelerating:self.imageScrollView];
    }];
}

- (void)endBackupTimer {
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(startBackupTimer) object:nil];
    [self.backupTimer invalidate];
    self.backupTimer = nil;
}

#pragma mark - ScrollViewDidScrollDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self endBackupTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self startBackupTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger page = [self calculateCurrentPageIndex:scrollView];
    if (page == self.currentPageIndex) { return; }
    self.currentPageIndex = page;
    
    [self.pageControl.layer removeAllSublayers];
    CGFloat padding = 3, layerSize = 4, curWidth = 8;
    CGFloat preLeft = 0;
    for (NSInteger i = self.itemTotalPageCount - 1; i >= 0; --i) {
        CALayer *layer = [CALayer layer];
        layer.size = CGSizeMake(layerSize, layerSize);
        layer.cornerRadius = 2;
        if (page == i) {
            layer.backgroundColor = UIColorHex(E7E7E7).CGColor;
            layer.width = curWidth;
        } else {
            layer.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.2].CGColor;
        }
        layer.centerY = self.pageControl.height / 2;
        if (self.itemTotalPageCount - 1 == i) {
            layer.right = self.pageControl.width - 12;
        } else {
            layer.right = preLeft - padding * 2;
        }
        [self.pageControl.layer addSublayer:layer];
        preLeft = layer.left;
    }
    self.pageControl.tag = preLeft - padding * 2;
    
    [self setUpData:page];
    
    scrollView.contentOffset = CGPointMake(self.width, 0);
}

- (void)dealloc {
    [self endBackupTimer];
}

@end
