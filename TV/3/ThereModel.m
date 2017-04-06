//
//  ThereModel.m
//  家居定制
//
//  Created by iKing on 2017/3/28.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ThereModel.h"

@implementation ThereModel
- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.avatar = dict[@"user"][@"url"];
        self.nickname = dict[@"user"][@"name"];
        self.title = dict[@"magazineName"];
        self.desc = dict[@"magazineTextContent"];
        self.image = dict[@"magazineUrlContent"];
        NSArray *praise = dict[@"thums"];
        self.praise = [NSString stringWithFormat:@"%ld", praise.count];
        NSArray *comments = dict[@"comments"];
        self.comment = [NSString stringWithFormat:@"%ld", comments.count];
        self.magazineId = dict[@"magazineId"];
        self.generateTime = dict[@"generateTime"];
    }
    return self;
}
@end
