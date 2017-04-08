//
//  CommonCell.m
//  家居定制
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CommonCell.h"

@interface CommonCell ()

@property (nonatomic, weak) UIImageView *avatar;///<<#注释#>
@property (nonatomic, weak) UILabel *nickname;///<<#注释#>
@property (nonatomic, weak) UILabel *commonLabel;///<<#注释#>
@property (nonatomic, weak) UILabel *timeLabel;///<<#注释#>
@end

@implementation CommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *avatar = [[UIImageView alloc] init];
        self.avatar = avatar;
        avatar.layer.cornerRadius = 20;
        avatar.layer.masksToBounds = YES;
        [self.contentView addSubview:avatar];
        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@14);
            make.top.equalTo(@14);
            make.width.height.equalTo(@40);
        }];
        
        UILabel *nickname = [UILabel labelWithText:@"" textColor:UIColorBlack fontSize:16];
        self.nickname = nickname;
        nickname.centerY = avatar.centerY;
        [self.contentView addSubview:nickname];
        [nickname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(avatar.mas_right).offset(15);
            make.centerY.equalTo(avatar);
            make.right.equalTo(@(-15));
        }];
        
        UILabel *common = [UILabel labelWithText:@"" textColor:RGB(107, 107, 107) fontSize:14];
        common.frame = CGRectMake(self.nickname.left, self.avatar.bottom, 0, 0);
        self.commonLabel = common;
        common.numberOfLines = 0;
        [self.contentView addSubview:common];
        [common mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(nickname);
            make.top.equalTo(avatar.mas_bottom);
            make.right.equalTo(@(-15));
        }];
        
        UILabel *time = [UILabel labelWithText:@"" textColor:RGB(107, 107, 107) fontSize:14];
        [self.contentView addSubview:time];
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(common.mas_bottom).offset(10);
            make.right.equalTo(@(-15));
            make.bottom.equalTo(@(-10));
        }];
        _timeLabel = time;
        UILabel *line = [[UILabel alloc] init];
        line.backgroundColor = RGB(208, 208, 208);
        [self.contentView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(@0);
            make.height.equalTo(@0.5);
        }];
    }
    return self;
}
- (void)setCellModel:(ScenceCommentModel *)cellModel {
    _cellModel = cellModel;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, cellModel.url]]];
    if (cellModel.name) {
        self.nickname.text = cellModel.name;
    } else {
        self.nickname.text = @"用户昵称";
    }
    self.commonLabel.text = cellModel.discussContent;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *time = [formatter dateFromString:cellModel.created];
    formatter.dateFormat = @"yyyy-MM-dd";
    self.timeLabel.text = [formatter stringFromDate:time];;
}


@end
