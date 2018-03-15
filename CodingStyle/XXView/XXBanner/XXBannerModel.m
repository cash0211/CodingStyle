//
//  XXBannerModel.m
//  XXHomePageDemo
//
//  Created by cash on 24/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXBannerModel.h"

@implementation XXBannerItem

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.itemId forKey:@"itemId"];
    [aCoder encodeObject:self.img    forKey:@"img"];
    [aCoder encodeObject:@(self.isShowFlag) forKey:@"isShowFlag"];
    [aCoder encodeObject:self.targetUrl forKey:@"targetUrl"];
    [aCoder encodeObject:self.title     forKey:@"title"];
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.itemId = [aDecoder decodeObjectForKey:@"itemId"];
        self.img    = [aDecoder decodeObjectForKey:@"img"];
        self.isShowFlag = [[aDecoder decodeObjectForKey:@"isShowFlag"] boolValue];
        self.targetUrl  = [aDecoder decodeObjectForKey:@"targetUrl"];
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

@implementation XXBannerModel

+ (NSDictionary<NSString *,Class> *)modelContainerPropertyGenericClass {
    return @{
             @"list" : [XXBannerItem class]
             };
}

@end
