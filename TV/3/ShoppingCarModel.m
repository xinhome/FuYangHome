//
//  ShoppingCarModel.m
//  家居定制
//
//  Created by iking on 2017/3/25.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ShoppingCarModel.h"

@implementation ShoppingCarModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"goodsId": @"id"};
}
//- (void)setValue:(id)value forUndefinedKey:(NSString *)key
//{
//    if ([key isEqualToString:@"id"]) {
//        _goodsId = value;
//    }
//}
@end
