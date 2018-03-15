//
//  XXRecommendModel.h
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXRecommendItem : NSObject <NSCoding>
@property(nonatomic, copy)   NSString *itemId;
@property(nonatomic, copy)   NSString *img;
@property(nonatomic, copy)   NSString *tags;
@property(nonatomic, copy)   NSString *targetUrl;
@property(nonatomic, copy)   NSString *title;
@property(nonatomic, assign) NSInteger index;
@end

@interface XXRecommendModel : NSObject
@property (nonatomic, copy) NSArray<XXRecommendItem *>* list;
@end
