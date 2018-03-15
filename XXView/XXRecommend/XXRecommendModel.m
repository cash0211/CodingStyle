//
//  XXRecommendModel.m
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXRecommendModel.h"

@implementation XXRecommendItem

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.itemId forKey:@"itemId"];
    [aCoder encodeObject:self.img    forKey:@"img"];
    [aCoder encodeObject:self.tags   forKey:@"tags"];
    [aCoder encodeObject:self.targetUrl forKey:@"targetUrl"];
    [aCoder encodeObject:self.title  forKey:@"title"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.itemId = [aDecoder decodeObjectForKey:@"itemId"];
        self.img    = [aDecoder decodeObjectForKey:@"img"];
        self.tags   = [aDecoder decodeObjectForKey:@"tags"];
        self.targetUrl = [aDecoder decodeObjectForKey:@"targetUrl"];
        self.title  = [aDecoder decodeObjectForKey:@"title"];
    }
    return self;
}

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"isShowFlag"  : @"showFlag"
             };
}

@end

@implementation XXRecommendModel

+ (NSDictionary<NSString *,Class> *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [XXRecommendItem class]
             };
}

@end
