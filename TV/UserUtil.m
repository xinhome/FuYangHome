//
//  UserUtil.m
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "UserUtil.h"

@implementation UserUtil
+ (instancetype)shareInstance {
    static UserUtil *util;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        util = [[UserUtil alloc] init];
    });
    return util;
}
- (void)saveUser:(User *)user {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:user];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"user"];
}
- (User *)takeoutUser {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:@"user"];
    if (data) {
        User *user = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        return user;
    }
    return nil;
}
- (void)saveAvatar:(NSString *)avatar {
    User *user = [self takeoutUser];
    user.avatar = avatar;
    [self saveUser:user];
}
- (void)saveNickname:(NSString *)nickname {
    User *user = [self takeoutUser];
    user.nickname = nickname;
    [self saveUser:user];
}
- (void)saveTelephone:(NSString *)telephone {
    User *user = [self takeoutUser];
    user.tel = telephone;
    [self saveUser:user];
}
@end
