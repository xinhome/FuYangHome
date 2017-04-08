//
//  MyTieZiTableViewCell.m
//  家居定制
//
//  Created by iking on 2017/3/24.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "MyTieZiTableViewCell.h"

@implementation MyTieZiTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubViews];
    }
    return self;
}
- (void)addSubViews
{
    UIButton *selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [selectBtn setImage:[UIImage imageNamed:@"没选中"] forState:(UIControlStateNormal)];
    [self addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(rateWidth(10));
        make.top.equalTo(self).offset(rateHeight(5));
        make.size.mas_offset(CGSizeMake(rateWidth(25), rateWidth(25)));
    }];
    self.selectBtn = selectBtn;
    
    UILabel *label1 = [UILabel labelWithText:@"一级大标题家居装饰" textColor:RGB(77, 77, 77) fontSize:16];
    label1.numberOfLines = 0;
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(rateHeight(25));
        make.left.equalTo(self).offset(rateWidth(25));
        make.width.equalTo(@(rateWidth(180)));
    }];
    self.label1 = label1;
    
    UILabel *label2 = [UILabel labelWithText:@"小常识关于家居" textColor:RGB(77, 77, 77) fontSize:16];
    label2.numberOfLines = 0;
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(rateHeight(10));
        make.left.equalTo(self).offset(rateWidth(25));
        make.width.equalTo(@(rateWidth(200)));
    }];
    self.label2 = label2;
    
    UIImageView *img = [UIImageView new];
    img.backgroundColor = [UIColor lightGrayColor];
    img.layer.masksToBounds = YES;
    img.layer.cornerRadius = 4;
    [self addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(rateWidth(5));
        make.right.equalTo(self).offset(-rateWidth(15));
        make.top.equalTo(label1);
        make.bottom.equalTo(self).offset(-rateHeight(20));
    }];
    self.img = img;
    
    self.pingLunBtn = [TieZiButtonViw new];
    self.pingLunBtn.numLB.text = @"12";
    [self.pingLunBtn.btn setImage:[UIImage imageNamed:@"comment1"] forState:(UIControlStateNormal)];
    [self addSubview:self.pingLunBtn];
    [self.pingLunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1);
        make.bottom.equalTo(img);
        make.size.mas_offset(CGSizeMake(rateWidth(50), rateHeight(23)));
    }];
    
    self.dianZanBtn = [TieZiButtonViw new];
    self.dianZanBtn.numLB.text = @"10";
    [self.dianZanBtn.btn setImage:[UIImage imageNamed:@"favor1"] forState:(UIControlStateNormal)];
    [self addSubview:self.dianZanBtn];
    [self.dianZanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.pingLunBtn.mas_right).offset(rateWidth(30));
        make.bottom.equalTo(img);
        make.size.mas_offset(CGSizeMake(rateWidth(50), rateHeight(23)));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
        make.height.equalTo(@(1));
    }];
}
- (void)setModel:(ThereModel *)model
{
    self.label1.text = model.name;
    self.label2.text = model.magazineName;
    [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", KAIKANG, [model.magazineUrlContent componentsSeparatedByString:@","].firstObject]]];
    self.pingLunBtn.numLB.text = model.count;
    self.dianZanBtn.numLB.text = model.likes;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
