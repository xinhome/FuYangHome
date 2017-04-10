//
//  SceneLeftCell.m
//  家居定制
//
//  Created by iKing on 2017/3/20.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SceneLeftCell.h"

@implementation SceneLeftCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectedBackgroundView:[UIView new]];
        self.backgroundColor = [UIColor clearColor];
        UILabel *date = [UILabel labelWithText:@"" textColor:RGB(96, 96, 96) fontSize:13];
        self.date = date;
        date.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:date];
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.equalTo(@0);
        }];
    }
    return self;
}

@end
