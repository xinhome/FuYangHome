//
//  User.h
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>
+ (instancetype)shareInstance;
@property (nonatomic, copy) NSString *ID;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *avatar; ///< 头像
@property (nonatomic, copy) NSString *nickname; ///< 昵称
@property (nonatomic, copy) NSString *credit; ///<积分
@end
