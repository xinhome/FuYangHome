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
        self.backgroundColor = [UIColor clearColor];
        UILabel *date = [UILabel labelWithText:@"5111111111222222222222222" textColor:RGB(0, 0, 0) fontSize:13];
        date.textAlignment = NSTextAlignmentCenter;
        date.frame = CGRectMake(0, 0, 60, 13);
        [self.contentView addSubview:date];
    }
    return self;
}

@end
