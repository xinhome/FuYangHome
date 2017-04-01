//
//  UserUtil.h
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserUtil : NSObject
+ (instancetype)shareInstance;
- (void)saveUser:(User *)user;
- (User *)takeoutUser;
- (void)saveAvatar:(NSString *)avatar;
@end
