//
//  CouponModel.h
//  家居定制
//
//  Created by iking on 2017/4/7.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CouponModel : NSObject

@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) NSString *startTime;
@property (nonatomic, strong) NSString *stopTime;
//@property (nonatomic, strong) NSString *validity; // 0可用
@property (nonatomic, strong) NSNumber *couponId;

@end
