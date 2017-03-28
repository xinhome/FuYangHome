//
//  BottomDeleteView.m
//  家居定制
//
//  Created by iking on 2017/3/24.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "BottomDeleteView.h"

@implementation BottomDeleteView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews
{
    UIButton *quanxuanBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [quanxuanBtn setImage:[UIImage imageNamed:@"全选"] forState:(UIControlStateNormal)];
    [self addSubview:quanxuanBtn];
    [quanxuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(rateWidth(25));
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(rateWidth(25), rateWidth(25)));
    }];
    self.selectAllBtn = quanxuanBtn;
    
    UILabel *quanxuan = [UILabel labelWithText:@"全选" textColor:[UIColor whiteColor] fontSize:17];
    [quanxuan sizeToFit];
    [self addSubview:quanxuan];
    [quanxuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self.mas_centerX).offset(-kScreenWidth/4);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor whiteColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(rateWidth(1), rateHeight(25)));
    }];
    
    UIButton *deleteBtn = [UIButton buttonWithTitle:@"删除" fontSize:17 titleColor:[UIColor whiteColor] background:[UIColor clearColor] cornerRadius:0];
    [deleteBtn sizeToFit];
    [self addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.centerX.equalTo(self.mas_centerX).offset(kScreenWidth/4);
    }];
    self.deleteBtn = deleteBtn;
    
}

@end
