//
//  CommunityDetailView.m
//  家居定制
//
//  Created by iKing on 2017/3/23.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CommunityDetailView.h"
#import "HPPhotoBrowser.h"

@interface CommunityDetailView ()

@property (nonatomic, strong) NSMutableArray<UIImageView *> *ivs;///<<#注释#>

@property (nonatomic, weak) UIImageView *avatar;///<<#注释#>
@property (nonatomic, weak) UILabel *nickname;///<<#注释#>
@property (nonatomic, weak) UILabel *title;///<<#注释#>
@property (nonatomic, weak) UILabel *desc;///<<#注释#>
@property (nonatomic, weak) UILabel *line1;///<<#注释#>
@property (nonatomic, weak) UILabel *commentLabel;///<<#注释#>
@property (nonatomic, weak) UILabel *line2;///<<#注释#>

@property (nonatomic, weak) UILabel *praiseLabel;///<<#注释#>
@end

@implementation CommunityDetailView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorWhite;
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(13, 15, 45, 45)];
        avatar.backgroundColor = [UIColor blueColor];
        avatar.layer.cornerRadius = 22.5;
        avatar.layer.masksToBounds = YES;
        [self addSubview:avatar];
        
        UILabel *nickname = [UILabel labelWithText:@"" textColor:RGB(130, 130, 130) fontSize:15];
        nickname.frame = CGRectMake(avatar.right+10, 0, kScreenWidth-avatar.right-10-20, 15);
        nickname.centerY = avatar.centerY;
        [self addSubview:nickname];
        
        UILabel *title = [UILabel labelWithText:@"" textColor:UIColorBlack fontSize:16];
        title.frame = CGRectMake(13, avatar.bottom+20, kScreenWidth-23, 16);
        [self addSubview:title];
        
        UILabel *content = [UILabel labelWithText:@"" textColor:RGB(88, 88, 88) fontSize:14];
        content.origin = CGPointMake(title.left, title.bottom+15);
        content.numberOfLines = 0;
        [self addSubview:content];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1)];
        line1.backgroundColor = RGB(235, 235, 235);
        [self addSubview:line1];
        
//        UIButton *comment = [UIButton buttonWithType:UIButtonTypeCustom];
//        [comment setImage:UIImageNamed(@"comment1") forState:UIControlStateNormal];
//        comment.frame = CGRectMake(32, line1.bottom+10, 230, 20);
//        [self addSubview:comment];
        UIImageView *comment = [[UIImageView alloc] initWithFrame:CGRectMake(32, line1.bottom+10, 22, 20)];
        comment.image = UIImageNamed(@"comment1");
        [self addSubview:comment];
        
        UILabel *commentLabel = [UILabel labelWithText:@"" textColor:RGB(88, 88, 88) fontSize:15];
        commentLabel.size = CGSizeMake(75, 15);
        [self addSubview:commentLabel];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 1, 20)];
        line2.backgroundColor = RGB(235, 235, 235);
        [self addSubview:line2];
        
        UIImageView *praise = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 22, 20)];
        praise.image = UIImageNamed(@"favor1");
        [self addSubview:praise];
        
        UILabel *praiseLabel = [UILabel labelWithText:@"" textColor:RGB(88, 88, 88) fontSize:15];
        [self addSubview:praiseLabel];
        
        _nickname = nickname;
        _avatar = avatar;
        _title = title;
        _desc = content;
        _line1 = line1;
        _comment = comment;
        _commentLabel = commentLabel;
        _line2 = line2;
        _praise = praise;
        _praiseLabel = praiseLabel;
    }
    return self;
}

- (void)setModel:(ThereModel *)model {
    _model = model;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, model.url]]];
    self.nickname.text = model.name;
    self.title.text = model.magazineName;
    CGSize strSize = [model.magazineTextContent getSizeWithMaxSize:CGSizeMake(kScreenWidth-26, CGFLOAT_MAX) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:14]}];
    self.desc.text = model.magazineTextContent;
    self.desc.size = strSize;
    NSArray *images = [model.magazineUrlContent componentsSeparatedByString:@","];
    for (int i = 0; i < images.count; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(13+(rateWidth(125))*(i%3), _desc.bottom+5+(rateWidth(125))*(i/3), rateWidth(115), rateWidth(115))];
        [imageView whenTapped:^{
            [HPPhotoBrowser showFromImageView:imageView inView:[UIApplication sharedApplication].keyWindow withURLStrings:images atIndex:i];
        }];
        imageView.backgroundColor = [UIColor blueColor];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WEIMING, images[i]]]];
        [self addSubview:imageView];
        self.line1.top = imageView.bottom+15;
        self.comment.top = self.line1.bottom+10;
        self.height = self.comment.bottom+10;
    }
//    self.commentLabel.text = model.comment;
    [self.commentLabel sizeToFit];
    self.commentLabel.centerY = self.comment.centerY;
    self.commentLabel.left = self.comment.right+15;
    self.line2.centerY = self.comment.centerY;
    self.line2.left = self.commentLabel.right+10;
    self.praise.centerY = self.line2.centerY;
    self.praise.left = self.line2.right+30;
    self.praiseLabel.text = model.praise;
    [self.praiseLabel sizeToFit];
    self.praiseLabel.centerY = self.line2.centerY;
    self.praiseLabel.left = self.praise.right+15;
}

- (NSMutableArray<UIImageView *> *)ivs {
    if (!_ivs) {
        _ivs = [NSMutableArray array];
    }
    return _ivs;
}

@end
