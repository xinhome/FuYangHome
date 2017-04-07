//
//  CouponModel.m
//  家居定制
//
//  Created by iking on 2017/4/7.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CouponModel.h"

@implementation CouponModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"id"]) {
        _couponId = value;
    }
}

@end
