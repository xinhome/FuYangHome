//
//  CommunityDetailView.m
//  家居定制
//
//  Created by iKing on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CommunityDetailView.h"

@interface CommunityDetailView ()

@property (nonatomic, strong) NSMutableArray<UIImageView *> *ivs;///<<#注释#>

@end

@implementation CommunityDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(13, 15, 45, 45)];
        avatar.backgroundColor = [UIColor blueColor];
        avatar.layer.cornerRadius = 22.5;
        avatar.layer.masksToBounds = YES;
        [self addSubview:avatar];
        
        UILabel *nickname = [UILabel labelWithText:@"用户名12345" textColor:RGB(130, 130, 130) fontSize:15];
        nickname.frame = CGRectMake(avatar.right+10, 0, kScreenWidth-avatar.right-10-20, 15);
        nickname.centerY = avatar.centerY;
        [self addSubview:nickname];
        
        UILabel *title = [UILabel labelWithText:@"求支招；怎么利用客厅更加合理" textColor:UIColorBlack fontSize:16];
        title.frame = CGRectMake(13, avatar.bottom+20, kScreenWidth-23, 16);
        [self addSubview:title];
        
        UILabel *content = [UILabel labelWithText:@"求支招；怎么利用" textColor:RGB(88, 88, 88) fontSize:14];
        content.numberOfLines = 0;
        [self addSubview:content];
        
        
    }
    return self;
}

- (NSMutableArray<UIImageView *> *)ivs {
    if (!_ivs) {
        _ivs = [NSMutableArray array];
    }
    return _ivs;
}

@end
