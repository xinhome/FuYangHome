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
@property (nonatomic, strong) NSMutableArray *comments;///<<#注释#>
@property (nonatomic, strong) NSMutableArray *magazines;///<<#注释#>
@property (nonatomic, strong) NSMutableArray *orderShoppings;///<<#注释#>
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *pone;
@property (nonatomic, copy) NSString *registrationTime;
@property (nonatomic, strong) NSMutableArray *thumbs;///<<#注释#>
@end
