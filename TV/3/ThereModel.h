//
//  ThereModel.h
//  家居定制
//
//  Created by iKing on 2017/3/28.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 社区model
@interface ThereModel : NSObject
@property (nonatomic, copy) NSString *generateTime;
@property (nonatomic, copy) NSString *magazineId;
@property (nonatomic, copy) NSString *magazineName;
@property (nonatomic, copy) NSString *magazineTextContent;
@property (nonatomic, copy) NSString *magazineUrlContent;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *praise;
@property (nonatomic, copy) NSString *image;
//- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
