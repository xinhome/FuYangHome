//
//  ConfirmOrderTableViewCell.m
//  家居定制
//
//  Created by iking on 2017/4/5.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ConfirmOrderTableViewCell.h"

@implementation ConfirmOrderTableViewCell

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
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView *image = [UIImageView new];
    image.backgroundColor = [UIColor whiteColor];
    [self addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(rateWidth(12));
        make.top.equalTo(self).offset(rateHeight(12));
        make.size.mas_offset(CGSizeMake(rateHeight(65), rateHeight(65)));
    }];
    self.goodsImg = image;
    
    UILabel *label1 = [UILabel labelWithText:@"产品名称" textColor:RGB(74, 74, 74) fontSize:14];
    label1.numberOfLines = 0;
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.top.equalTo(image).offset(rateHeight(5));
        make.width.equalTo(@(rateWidth(170)));
    }];
    self.nameLB = label1;
    
    UILabel *label30 = [UILabel labelWithText:@"￥50.00" textColor:RGB(242, 0, 0) fontSize:14];
    [label30 sizeToFit];
    [self addSubview:label30];
    [label30 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1);
        make.right.equalTo(self).offset(-rateWidth(20));
    }];
    self.realPriceLB = label30;
    
    UILabel *label31 = [UILabel labelWithText:@"￥60.00" textColor:RGB(173, 173, 173) fontSize:13];
    [label31 sizeToFit];
    [self addSubview:label31];
    [label31 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label30.mas_bottom);
        make.left.equalTo(label30);
    }];
    self.priceLB = label31;
    
    UIView *redLine = [UIView new];
    redLine.backgroundColor = RGB(242, 0, 0);
    [self addSubview:redLine];
    [redLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label31);
        make.right.equalTo(label31).offset(1);
        make.height.equalTo(@(1));
        make.top.equalTo(label31.mas_centerY);
    }];
    
    UILabel *label3 = [UILabel labelWithText:@"颜色：；尺寸：" textColor:RGB(173, 173, 173) fontSize:14];
    [label3 sizeToFit];
    [self addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.bottom.equalTo(image.mas_bottom).offset(-rateHeight(5));
    }];
    self.colorLB = label3;
    
    UILabel *label4 = [UILabel labelWithText:@"×2" textColor:RGB(173, 173, 173) fontSize:14];
    [label4 sizeToFit];
    [self addSubview:label4];
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-rateWidth(20));
        make.bottom.equalTo(label3);
    }];
    self.numLB = label4;
    
    UIView *line = [UIView new];
    line.backgroundColor = RGB(240, 240, 240);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(rateHeight(1)));
    }];
}
- (void)setCellModel:(ShoppingCarModel *)cellModel
{
    self.nameLB.text = cellModel.title;
    self.priceLB.text = [NSString stringWithFormat:@"￥%.2f", [cellModel.price floatValue]];
    self.realPriceLB.text = [NSString stringWithFormat:@"￥%.2f", [cellModel.price floatValue]];
    self.numLB.text = [NSString stringWithFormat:@"×%d", [cellModel.num intValue]];
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WeiMingURL,cellModel.picPath]];
    [self.goodsImg sd_setImageWithURL:imgUrl];
    self.colorLB.text = [NSString stringWithFormat:@"颜色:%@;尺寸:%@",cellModel.colour, cellModel.style];
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
