//
//  XXInteractionNotification.m
//  XXInteractionNotificationDemo
//
//  Created by cash on 23/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import "XXInteractionNotification.h"

@implementation XXInteractionNotificationUserInfo

@end


@implementation XXInteractionNotificationItem

@end


@implementation XXInteractionNotification

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary<NSString *,id> *)dic {
    if ([[dic allKeys] containsObject:@"msgList"]) {
        //        self.msgList = json to XXInteractionNotificationItem
    } else if ([[dic allKeys] containsObject:@"praiseList"]) {
        //        self.msgList = json to XXInteractionNotificationItem
    }
    return YES;
}

@end
