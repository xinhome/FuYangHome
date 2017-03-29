//
//  AddAddressCell.m
//  家居定制
//
//  Created by iKing on 2017/3/18.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "AddAddressCell.h"

@implementation AddAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *addBtn = [UIButton buttonWithTitle:@"添加地址" fontSize:18 titleColor:RGB(44, 194, 167) background:[UIColor clearColor] cornerRadius:10];
        addBtn.layer.borderColor = [RGB(44, 194, 167) CGColor];
        addBtn.layer.borderWidth = 1;
        addBtn.frame = CGRectMake(0, 0, rateWidth(230), 54);
        self.addAddressBtn = addBtn;
        [self.contentView addSubview:addBtn];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.addAddressBtn.center = self.contentView.center;
}

@end
