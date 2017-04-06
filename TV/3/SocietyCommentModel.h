//
//  SocietyCommentModel.h
//  家居定制
//
//  Created by iKing on 2017/4/5.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

/// 社区评论model
@interface SocietyCommentModel : NSObject
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, copy) NSString *commentContent;
@property (nonatomic, copy) NSString *commentTime;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
@end
