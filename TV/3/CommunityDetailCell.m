//
//  CommunityDetailCell.m
//  家居定制
//
//  Created by iKing on 2017/3/29.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CommunityDetailCell.h"

@interface CommunityDetailCell ()
@property (nonatomic, weak) UIImageView *avatar;///<<#注释#>
@property (nonatomic, weak) UILabel *nickname;///<<#注释#>
@property (nonatomic, weak) UILabel *commentLabel;///<<#注释#>
@property (nonatomic, weak) UILabel *timeLabel;///<<#注释#>
@end

@implementation CommunityDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *avatar = [[UIImageView alloc] init];
        avatar.backgroundColor = [UIColor blueColor];
        avatar.layer.cornerRadius = 35/2;
        avatar.layer.masksToBounds = YES;
        [self.contentView addSubview:avatar];
        [avatar mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@12);
            make.width.height.equalTo(@35);
        }];
        
        UILabel *nickname = [UILabel labelWithText:@"" textColor:RGB(90, 90, 90) fontSize:15];
        [self.contentView addSubview:nickname];
        [nickname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(avatar.mas_right).offset(10);
            make.centerY.equalTo(avatar);
            make.right.equalTo(@(-20));
        }];
        
        UILabel *content = [UILabel labelWithText:@"" textColor:RGB(171, 171, 171) fontSize:14];
        content.numberOfLines = 0;
        [self.contentView addSubview:content];
        [content mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(avatar.mas_bottom);
            make.left.equalTo(nickname);
            make.right.equalTo(@(-17));
        }];
        
        UILabel *date = [UILabel labelWithText:@"" textColor:RGB(171, 171, 171) fontSize:13];
        [self.contentView addSubview:date];
        [date mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(content.mas_bottom).offset(10);
            make.right.equalTo(@(-17));
            make.bottom.equalTo(@(-5));
        }];
        _avatar = avatar;
        _nickname = nickname;
        _commentLabel = content;
        _timeLabel = date;
    }
    return self;
}
- (void)setModel:(SocietyCommentModel *)model {
    _model = model;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, model.url]] placeholderImage:UIImageNamed(@"Icon2")];
    if (model.name) {
        self.nickname.text = model.name;
    } else {
        self.nickname.text = @"用户昵称";
    }
    self.commentLabel.text = model.commentContent;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [formatter dateFromString:model.generateTime];
    formatter.dateFormat = @"MM月dd日";
    self.timeLabel.text = [formatter stringFromDate:date];
}

+ (CGFloat)cellHeightForModel:(SocietyCommentModel *)model {
    return 75 + [model.commentContent getSizeWithMaxSize:CGSizeMake(kScreenWidth-45-17, CGFLOAT_MAX) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}].height;
    
}

@end
