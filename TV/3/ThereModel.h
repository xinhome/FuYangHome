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

@property (nonatomic, copy) NSString *magazineId;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *comment;
@property (nonatomic, copy) NSString *praise;
@property (nonatomic, copy) NSString *image;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
