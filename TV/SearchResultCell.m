//
//  SearchResultCell.m
//  家居定制
//
//  Created by iKing on 2017/3/25.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "SearchResultCell.h"

@interface SearchResultCell ()

@property (nonatomic, weak) UIImageView *avatarIV;///<<#注释#>
@property (nonatomic, weak) UILabel *nicknameLabel;///<<#注释#>
@property (nonatomic, weak) UILabel *contentLabel;///<<#注释#>
@end

@implementation SearchResultCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *avatar = [[UIImageView alloc] init];
        avatar.layer.cornerRadius = 15;
        avatar.layer.masksToBounds = YES;
        [self.contentView addSubview:avatar];
        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@11);
            make.top.equalTo(@13);
            make.width.height.equalTo(@30);
        }];
        UILabel *nickname = [UILabel labelWithText:@"用户12345" textColor:UIColorBlack fontSize:17];
        [self.contentView addSubview:nickname];
        [nickname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(avatar.mas_right).offset(10);
            make.centerY.equalTo(avatar);
            make.right.equalTo(@(-15));
        }];
        
        UILabel *content = [UILabel labelWithText:@"大姐夫看来大家撒六块腹肌代理商卡积分离开就开了房间束带结发 " textColor:RGB(0, 0, 0) fontSize:16];
        content.numberOfLines = 0;
        [self.contentView addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(-15));
            make.left.equalTo(nickname);
            make.top.equalTo(avatar.mas_bottom);
            make.bottom.equalTo(@(-15));
        }];
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = RGB(208, 208, 208);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
        _avatarIV = avatar;
        _nicknameLabel = nickname;
        _contentLabel = content;
        
    }
    return self;
}

- (void)setCellModel:(ThereModel *)cellModel {
    _cellModel = cellModel;
    [self.avatarIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, cellModel.url]] placeholderImage:UIImageNamed(@"Icon2")];
    self.nicknameLabel.text = cellModel.name;
    self.contentLabel.text = cellModel.magazineName;
}

@end
