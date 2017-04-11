//
//  UserHeaderView.m
//  家居定制
//
//  Created by iKing on 2017/3/17.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "UserHeaderView.h"

@implementation UserHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 60, 60)];
        self.avatar = avatar;
        self.avatar.backgroundColor = [UIColor blueColor];
        avatar.layer.cornerRadius = 30;
        avatar.layer.masksToBounds = YES;
        avatar.centerX = self.centerX;
        [self addSubview:avatar];
        
        UILabel *nickname = [UILabel labelWithText:@"" textColor:UIColorBlack fontSize:16];
        self.nickname = nickname;
        nickname.frame = CGRectMake(0, avatar.bottom+15, kScreenWidth, 16);
        nickname.textAlignment = NSTextAlignmentCenter;
        [self addSubview:nickname];
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, nickname.bottom+15, kScreenWidth, 1)];
        line1.backgroundColor = RGB(189, 189, 189);
        [self addSubview:line1];
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, line1.bottom, kScreenWidth, 70)];
        [view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)]];
        [self addSubview:view];
        
        UILabel *post = [UILabel labelWithText:@"0" textColor:RGB(140, 139, 140) fontSize:16];
        self.invitation = post;
        post.textAlignment = NSTextAlignmentCenter;
        post.frame = CGRectMake(0, 13, kScreenWidth/4, 16);
        [view addSubview:post];
        UILabel *order = [UILabel labelWithText:@"0" textColor:RGB(140, 139, 140) fontSize:16];
        self.order = order;
        order.textAlignment = NSTextAlignmentCenter;
        order.frame = CGRectMake(post.right, 13, kScreenWidth/4, 16);
        [view addSubview:order];
        UILabel *shopcar = [UILabel labelWithText:@"0" textColor:RGB(140, 139, 140) fontSize:16];
        self.shopCar = shopcar;
        shopcar.textAlignment = NSTextAlignmentCenter;
        shopcar.frame = CGRectMake(order.right, 13, kScreenWidth/4, 16);
        [view addSubview:shopcar];
        UILabel *goods = [UILabel labelWithText:@"0" textColor:RGB(140, 139, 140) fontSize:16];
        self.goodsLabel = goods;
        goods.textAlignment = NSTextAlignmentCenter;
        goods.frame = CGRectMake(shopcar.right, 13, kScreenWidth/4, 16);
        [view addSubview:goods];
        
        UILabel *label1 = [UILabel labelWithText:@"我的帖子" textColor:RGB(140, 139, 140) fontSize:16];
        label1.textAlignment = NSTextAlignmentCenter;
        label1.frame = CGRectMake(0, post.bottom+10, kScreenWidth/4, 16);
        [view addSubview:label1];
        UILabel *label2 = [UILabel labelWithText:@"我的订单" textColor:RGB(140, 139, 140) fontSize:16];
        label2.textAlignment = NSTextAlignmentCenter;
        label2.frame = CGRectMake(post.right, label1.top, kScreenWidth/4, 16);
        [view addSubview:label2];
        UILabel *label3 = [UILabel labelWithText:@"购物车" textColor:RGB(140, 139, 140) fontSize:16];
        label3.textAlignment = NSTextAlignmentCenter;
        label3.frame = CGRectMake(order.right, label1.top, kScreenWidth/4, 16);
        [view addSubview:label3];
        UILabel *label4 = [UILabel labelWithText:@"退换货" textColor:RGB(140, 139, 140) fontSize:16];
        label4.textAlignment = NSTextAlignmentCenter;
        label4.frame = CGRectMake(shopcar.right, label1.top, kScreenWidth/4, 16);
        [view addSubview:label4];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(post.right, 22, 1, 27)];
        line2.backgroundColor = RGB(230, 230, 230);
        [view addSubview:line2];
        
        UILabel *line3 = [[UILabel alloc] initWithFrame:CGRectMake(order.right, 22, 1, 27)];
        line3.backgroundColor = RGB(230, 230, 230);
        [view addSubview:line3];
        
        UILabel *line4 = [[UILabel alloc] initWithFrame:CGRectMake(shopcar.right, 22, 1, 27)];
        line4.backgroundColor = RGB(230, 230, 230);
        [view addSubview:line4];
        
        UILabel *grade = [UILabel labelWithText:@"               " textColor:RGB(168, 168, 168) fontSize:14];
        self.gradeLabel = grade;
        [grade sizeToFit];
        grade.centerY = avatar.centerY;
        grade.right = kScreenWidth-rateWidth(30);
        [self addSubview:grade];
        
        UIImageView *gradeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 20, 25)];
        self.gradeImageView = gradeImageView;
        gradeImageView.right = grade.left-15;
        gradeImageView.centerY = grade.centerY;
        [self addSubview:gradeImageView];
        
        UILabel *score = [UILabel labelWithText:@"" textColor:RGB(168, 168, 168) fontSize:14];
        self.scoreLabel = score;
        score.frame = CGRectMake(grade.left, gradeImageView.bottom, kScreenWidth-grade.left, 14);
        [self addSubview:score];
    }
    return self;
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    CGFloat x = [tap locationInView:tap.view].x;
    if (x<kScreenWidth/4) {
        self.postAction();
    } else if (x<kScreenWidth/4*2) {
        self.orderAction();
    } else if (x<kScreenWidth/4*3) {
        self.shopCarAction();
    } else {
        self.goodsAction();
    }
}

@end
