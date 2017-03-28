//
//  SearchResultCell.m
//  家居定制
//
//  Created by iKing on 2017/3/25.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SearchResultCell.h"

@implementation SearchResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(11, 13, 30, 30)];
        avatar.layer.cornerRadius = 15;
        avatar.layer.masksToBounds = YES;
        [self.contentView addSubview:avatar];
        UILabel *nickname = [UILabel labelWithText:@"" textColor:UIColorBlack fontSize:12];
        //sdifjkldsjkljsfkljfk
    }
    return self;
}

@end
