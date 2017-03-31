//
//  GoodsCommentCell.m
//  家居定制
//
//  Created by iKing on 2017/3/31.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "GoodsCommentCell.h"

@interface GoodsCommentCell ()



@end

@implementation GoodsCommentCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *avatar = [[UIImageView alloc] init];
        avatar.backgroundColor = [UIColor blueColor];
        avatar.layer.cornerRadius = 20;
        avatar.layer.masksToBounds = YES;
        [self.contentView addSubview:avatar];
        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@13);
            make.width.height.equalTo(@40);
        }];
        
        UILabel *nickname = [UILabel labelWithText:@"用户名称123" textColor:UIColorFromRGB(0x333333) fontSize:16];
        [self.contentView addSubview:nickname];
        [nickname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(avatar.mas_right).offset(10);
            make.centerY.equalTo(avatar);
            make.right.equalTo(@(-20));
        }];
        
        UILabel *comment = [UILabel labelWithText:@"用户评论用户评论用户评论用户评论用户评论用户评论用户评论用户评论用户评论用户评论用户评论用户评论用户评论用户评论用户评论用户评论用户评论" textColor:UIColorFromRGB(0x808080) fontSize:15];
        comment.numberOfLines = 0;
        [self.contentView addSubview:comment];
        [comment mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(avatar);
            make.top.equalTo(avatar.mas_bottom).offset(15);
            make.right.equalTo(@(-20));
        }];
        
        UILabel *time = [UILabel labelWithText:@"2016-03-02 15:30" textColor:UIColorFromRGB(0xbfbfbf) fontSize:13];
        [self.contentView addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(comment.mas_bottom).offset(15);
            make.right.equalTo(@(-20));
            make.bottom.equalTo(@(-15));
        }];
        
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = UIColorFromRGB(0xcccccc);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@13);
            make.height.equalTo(@1);
            make.right.equalTo(@(-13));
            make.bottom.equalTo(@0);
        }];
    }
    return self;
}

@end
