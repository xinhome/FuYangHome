//
//  ShoppingCartTableViewCell.m
//  家居定制
//
//  Created by iking on 2017/3/24.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ShoppingCartTableViewCell.h"

@implementation ShoppingCartTableViewCell

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
    self.contentView.backgroundColor = RGB(239, 239, 239);
    
    UIButton *selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [selectBtn setImage:[UIImage imageNamed:@"没选中"] forState:(UIControlStateNormal)];
    [self addSubview:selectBtn];
    [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(rateWidth(20));
        make.top.equalTo(self).offset(rateHeight(10));
        make.size.mas_offset(CGSizeMake(rateWidth(25), rateWidth(25)));
    }];
    self.selectBtn = selectBtn;
    
    UIImageView *image = [UIImageView new];
    image.backgroundColor = [UIColor whiteColor];
    [self addSubview:image];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(rateWidth(45));
        make.centerY.equalTo(self);
        make.size.mas_offset(CGSizeMake(rateHeight(95), rateHeight(95)));
    }];
    self.goodsImg = image;
    
    UILabel *label1 = [UILabel labelWithText:@"产品名称" textColor:RGB(74, 74, 74) fontSize:15];
    label1.numberOfLines = 0;
    [self addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.top.equalTo(image);
        make.width.equalTo(@(rateWidth(160)));
    }];
    self.nameLB = label1;
    
    UILabel *label2 = [UILabel labelWithText:@"颜色：红色" textColor:RGB(100, 100, 100) fontSize:14];
    [label2 sizeToFit];
    [self addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.centerY.equalTo(image);
    }];
    self.colorLB = label2;
    
    UILabel *label3 = [UILabel labelWithText:@"￥50.00" textColor:RGB(242, 0, 0) fontSize:14];
    [label3 sizeToFit];
    [self addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(rateWidth(15));
        make.bottom.equalTo(image.mas_bottom).offset(-rateHeight(5));
    }];
    self.priceLB = label3;
    
    self.numBtn = [ShoppingCartButtonView new];
    self.numBtn.backgroundColor = [UIColor clearColor];
    [self addSubview:self.numBtn];
    [self.numBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceLB);
        make.right.equalTo(self).offset(-rateWidth(20));
        make.size.mas_offset(CGSizeMake(rateWidth(120), rateWidth(30)));
    }];
    self.numBtn.numLB.text = [NSString stringWithFormat:@"%ld", (long)self.num];
    [self.numBtn.subtractBtn addTarget:self action:@selector(actionSubtract:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.numBtn.addButton addTarget:self action:@selector(actionAdd:) forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *deleteBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [deleteBtn setImage:[UIImage imageNamed:@"删除"] forState:(UIControlStateNormal)];
    [self addSubview:deleteBtn];
    [deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-rateWidth(15));
        make.top.equalTo(self).offset(rateHeight(10));
        make.size.mas_offset(CGSizeMake(rateWidth(35), rateWidth(35)));
    }];
    self.deleteBtn = deleteBtn;
    self.deleteBtn.hidden = YES;
}
- (void)actionSubtract:(UIButton *)btn
{
    if (self.num > 1) {
        self.num = self.num - 1;
        [self editGoodsNum];
    }
}
- (void)actionAdd:(UIButton *)btn
{
    self.num = self.num + 1;
    [self editGoodsNum];
}
- (void)setCellModel:(ShoppingCarModel *)cellModel
{
    self.nameLB.text = cellModel.title;
    self.colorLB.text = [NSString stringWithFormat:@"颜色：%@", cellModel.colour];
    self.priceLB.text = [NSString stringWithFormat:@"￥%.2f", [cellModel.price floatValue]];
    self.num = cellModel.num;
    self.numBtn.numLB.text = [NSString stringWithFormat:@"%ld", (long)self.num];
    NSURL *imgUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", WeiMingURL,cellModel.picPath]];
    [self.goodsImg sd_setImageWithURL:imgUrl];
    self.orderId = cellModel.orderId;
}
#pragma mark - 编辑商品数量
- (void)editGoodsNum
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults valueForKey:@"myUserId"];
    [[HttpRequestManager shareManager] addPOSTURL:@"/Order/updateCar" person:RequestPersonWeiMing parameters:@{@"userId":userId,@"orderId":self.orderId,@"num":@(self.num)} success:^(id successResponse) {
        if ([successResponse isSuccess]) {
            self.numBtn.numLB.text = [NSString stringWithFormat:@"%ld", (long)self.num];
        } else {
            [MBProgressHUD showResponseMessage:successResponse];
        }
    } fail:^(NSError *error) {
        [MBProgressHUD showError:@"网络异常"];
    }];
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
