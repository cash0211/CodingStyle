//
//  XXInteractionNotification.h
//  XXInteractionNotificationDemo
//
//  Created by cash on 23/02/2018.
//  Copyright © 2018 cash. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XXInteractionNotificationUserInfo : NSObject
@property (nonatomic, copy) NSString *facePic;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *loginname;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *username;
@end

@interface XXInteractionNotificationItem : NSObject
@property (nonatomic, copy) NSString   *call;
@property (nonatomic, copy) NSString   *createTime;
@property (nonatomic, strong) XXInteractionNotificationUserInfo *doUserInfo;
@property (nonatomic, copy) NSString   *idKey;
@property (nonatomic, strong) XXInteractionNotificationUserInfo *parentUserInfo;
@property (nonatomic, strong) NSNumber *praiseCount;
@property (nonatomic, copy) NSArray<NSString *> *praiseList;
@property (nonatomic, copy) NSString   *remarkContent;
@property (nonatomic, strong) NSNumber *remarkDel;
@property (nonatomic, copy) NSString   *remarkId;
@property (nonatomic, copy) NSString   *replyContent;
@property (nonatomic, strong) NSNumber *replyDel;
@property (nonatomic, copy) NSString   *replyId;
@property (nonatomic, copy) NSString   *topicContent;
@property (nonatomic, strong) NSNumber *topicDel;
@property (nonatomic, copy) NSString   *topicId;
@property (nonatomic, copy) NSString   *topicImg;
@property (nonatomic, copy) NSString   *topicTitle;
@property (nonatomic, assign) BOOL     isVideoPost;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) XXInteractionNotificationUserInfo *praiseUser;
@end

@interface XXInteractionNotification : NSObject
@property (nonatomic, copy)   NSArray<XXInteractionNotificationItem *>  *msgList;
@property (nonatomic, strong) NSNumber *lastTime;
@property (nonatomic, strong) NSNumber *totalCount;
@end
