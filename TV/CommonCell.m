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
@end

@implementation CommonCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(14, 14, 40, 40)];
        self.avatar = avatar;
        avatar.backgroundColor = [UIColor redColor];
        avatar.layer.cornerRadius = 20;
        avatar.layer.masksToBounds = YES;
        [self.contentView addSubview:avatar];
        
        UILabel *nickname = [UILabel labelWithText:@"用户名12345" textColor:UIColorBlack fontSize:16];
        self.nickname = nickname;
        nickname.frame = CGRectMake(avatar.right+15, 0, kScreenWidth-avatar.right-15, 16);
        nickname.centerY = avatar.centerY;
        [self.contentView addSubview:nickname];
        
        UILabel *common = [UILabel labelWithText:@"评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容评论内容" textColor:RGB(107, 107, 107) fontSize:14];
        common.frame = CGRectMake(self.nickname.left, self.avatar.bottom, 0, 0);
        self.commonLabel = common;
        common.numberOfLines = 0;
        [self.contentView addSubview:common];
    }
    return self;
}

- (void)setCommon:(NSString *)common {
    _common = common;
    self.commonLabel.size = [common getSizeWithMaxSize:CGSizeMake(kScreenWidth-80, CGFLOAT_MAX) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
}

+ (CGFloat)heightForCell:(NSString *)common {
    CGSize strSize = [common getSizeWithMaxSize:CGSizeMake(kScreenWidth-80, CGFLOAT_MAX) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    return strSize.height+64;
}

@end
