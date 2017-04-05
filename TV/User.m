//
//  User.m
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "User.h"

@implementation User
+ (instancetype)shareInstance {
    static User *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[User alloc] init];
    });
    return user;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        _ID = [aDecoder decodeObjectForKey:@"userId"];
        _tel = [aDecoder decodeObjectForKey:@"tel"];
        _avatar = [aDecoder decodeObjectForKey:@"avatar"];
        _nickname = [aDecoder decodeObjectForKey:@"nickname"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:_ID forKey:@"userId"];
    [aCoder encodeObject:_tel forKey:@"tel"];
    [aCoder encodeObject:_avatar forKey:@"avatar"];
    [aCoder encodeObject:_nickname forKey:@"nickname"];
}
@end
