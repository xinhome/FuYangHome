//
//  OrderTableViewCell.m
//  家居定制
//
//  Created by iking on 2017/4/7.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "OrderTableViewCell.h"

@implementation OrderTableViewCell

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
    self.contentView.backgroundColor = UIColorFromRGB(0xf7f7f7);
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
    [label1 sizeToFit];
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.top.equalTo(image).offset(rateHeight(5));
        make.width.equalTo(@(rateWidth(260)));
    }];
    self.nameLB = label1;
    
    UILabel *label2 = [UILabel labelWithText:@"数量：1件" textColor:RGB(74, 74, 74) fontSize:14];
    [label2 sizeToFit];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.centerY.equalTo(image);
    }];
    self.numLB = label2;
    
    UILabel *label3 = [UILabel labelWithText:@"单价：￥50.00" textColor:RGB(242, 0, 0) fontSize:14];
    [label3 sizeToFit];
    [self addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.bottom.equalTo(image.mas_bottom).offset(-rateHeight(5));
    }];
    self.priceLB = label3;
    
    self.shouHouBtn = [UIButton buttonWithTitle:@"申请售后" fontSize:12 titleColor:UIColorFromRGB(0x4fd2c2) background:[UIColor clearColor] cornerRadius:4];
    _shouHouBtn.layer.masksToBounds = YES;
    _shouHouBtn.layer.borderColor = UIColorFromRGB(0x4fd2c2).CGColor;
    _shouHouBtn.layer.borderWidth = 1;
    [self addSubview:_shouHouBtn];
    [_shouHouBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-rateWidth(20));
        make.bottom.equalTo(self.goodsImg);
        make.size.mas_offset(CGSizeMake(rateWidth(70), rateHeight(24)));
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = [UIColor whiteColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(rateHeight(3)));
    }];
}
- (void)setCellModel:(ShoppingCarModel *)cellModel
{
    self.nameLB.text = cellModel.title;
    self.priceLB.text = [NSString stringWithFormat:@"￥%.2f", [cellModel.price floatValue]];
    self.numLB.text = [NSString stringWithFormat:@"数量：%d", [cellModel.num intValue]];
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WeiMingURL,cellModel.picPath]];
    [self.goodsImg sd_setImageWithURL:imgUrl];
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
