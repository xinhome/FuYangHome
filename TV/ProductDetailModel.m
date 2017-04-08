//
//  ProductDetailModel.m
//  家居定制
//
//  Created by iKing on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID": @"id"};
}
+ (NSDictionary *)mj_objectClassInArray {
    return @{@"orderMsgs": @"ProductCommentModel"};
}
@end
