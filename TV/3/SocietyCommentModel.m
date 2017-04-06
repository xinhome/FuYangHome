//
//  SocietyCommentModel.m
//  家居定制
//
//  Created by iKing on 2017/4/5.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SocietyCommentModel.h"

@implementation SocietyCommentModel
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.avatar = dict[@"reviewer"][@"url"];
        self.nickname = dict[@"reviewer"][@"name"];
        self.commentContent = dict[@"commentContent"];
        self.commentTime = dict[@"generateTime"];
    }
    return self;
}
@end
