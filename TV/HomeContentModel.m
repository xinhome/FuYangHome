//
//  HomeContentModel.m
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "HomeContentModel.h"

@implementation HomeContentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"ID": @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray {
    return @{
             @"items": @"Items"
             };
}
@end

@implementation Items

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}

@end
