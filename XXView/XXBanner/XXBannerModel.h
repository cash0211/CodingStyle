//
//  XXBannerModel.h
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXBannerItem : NSObject <NSCoding>
@property (nonatomic, copy)   NSString *itemId;
@property (nonatomic, copy)   NSString *img;
@property (nonatomic, assign) BOOL      isShowFlag;
@property (nonatomic, copy)   NSString *targetUrl;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, assign) NSInteger index;
@end

@interface XXBannerModel : NSObject
@property (nonatomic, copy) NSArray<XXBannerItem *>* list;
@end
