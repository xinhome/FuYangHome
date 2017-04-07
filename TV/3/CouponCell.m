//
//  CouponCell.m
//  家居定制
//
//  Created by iKing on 2017/4/6.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "CouponCell.h"

@implementation CouponCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setUpUI];
    }
    return self;
}
- (void)setUpUI
{
    self.contentView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.equalTo(self);
        make.width.equalTo(@(rateWidth(300)));
    }];
    self.bgImg = imageView;
    _bgImg.image = [UIImage imageNamed:@"立即使用"];
    
    UILabel *label = [UILabel labelWithText:@"￥" textColor:UIColorFromRGB(0xffc332) fontSize:16];
    [label sizeToFit];
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_bgImg).offset(rateWidth(10));
        make.bottom.equalTo(_bgImg).offset(-rateHeight(20));
    }];
    self.label = label;
    
    self.moneyLB = [UILabel labelWithText:@"100" textColor:UIColorFromRGB(0xffc332) fontSize:70];
    [_moneyLB sizeToFit];
    [self.contentView addSubview:_moneyLB];
    [_moneyLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_bgImg);
        make.left.equalTo(label.mas_right);
    }];
    
    self.conditionLB = [UILabel labelWithText:@"满200使用"textColor:UIColorFromRGB(0xffc332) fontSize:10];
    [_conditionLB sizeToFit];
    [self.contentView addSubview:_conditionLB];
    [_conditionLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(label);
        make.right.equalTo(_bgImg).offset(-rateWidth(100));
    }];
    self.conditionLB.hidden = YES;
    
    self.timeLB = [UILabel labelWithText:@"有效期：2011-09-08日至2017-08-08" textColor:UIColorFromRGB(0xadadad) fontSize:8];
    [_timeLB sizeToFit];
    [self.contentView addSubview:_timeLB];
    [_timeLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_bgImg).offset(-rateHeight(5));
        make.left.equalTo(label);
    }];
}
- (void)setCellModel:(CouponModel *)cellModel
{
    self.moneyLB.text = cellModel.amount;
    NSString *str1 = [cellModel.startTime substringToIndex:10];
    NSString *str2 = [cellModel.stopTime substringToIndex:10];
    self.timeLB.text = [NSString stringWithFormat:@"有效期：%@日至%@日", str1,str2];
}

@end
