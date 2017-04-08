//
//  AddressCell.m
//  家居定制
//
//  Created by iKing on 2017/3/18.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *border = [[UIImageView alloc] init];
        self.border = border;
        border.highlightedImage = [UIImage imageNamed:@"dizhikuang"];
        border.image = UIImageNamed(@"灰框");
        [self.contentView addSubview:border];
        [border mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@30);
            make.top.equalTo(@0);
            make.right.equalTo(@(-30));
            make.height.equalTo(@175);
        }];
        
        UIImageView *iv = [[UIImageView alloc] init];
        iv.hidden = YES;
        self.iv = iv;
        iv.highlightedImage = UIImageNamed(@"selected");
        iv.image = UIImageNamed(@"unselect");
        [self.contentView addSubview:iv];
        [iv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.equalTo(@0);
            make.width.height.equalTo(@25);
        }];
        
        UILabel *label1 = [UILabel labelWithText:@"收货地址:" textColor:RGB(142, 142, 142) fontSize:16];
        [self.contentView addSubview:label1];
        [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@35);
            make.top.equalTo(@20);
            make.width.equalTo(@70);
        }];
        
        UILabel *address = [UILabel labelWithText:@"" textColor:RGB(142, 142, 142) fontSize:16];
        self.address = address;
        address.numberOfLines = 0;
//        address.lineBreakMode = NSLineBreakByCharWrapping;
        address.frame = CGRectMake(label1.right+5, 20, 0, 0);
        [self.contentView addSubview:address];
        [address mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label1.mas_right).offset(5);
            make.right.equalTo(@(-35));
            make.top.equalTo(@20);
        }];
        
        UILabel *line1 = [[UILabel alloc] init];
        line1.backgroundColor = RGB(240, 240, 240);
        [self.contentView addSubview:line1];
        [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@30);
            make.top.equalTo(address.mas_bottom).offset(5);
            make.width.equalTo(border);
            make.height.equalTo(@1);
        }];
        
        UILabel *label2 = [UILabel labelWithText:@"收货人:" textColor:RGB(142, 142, 142) fontSize:16];
        label2.frame = CGRectMake(35, line1.bottom+20, 55, 16);
        [self.contentView addSubview:label2];
        [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@35);
            make.top.equalTo(line1.mas_bottom).offset(20);
        }];
        
        UILabel *contact = [UILabel labelWithText:@"" textColor:RGB(142, 142, 142) fontSize:16];
        self.contact = contact;
//        contact.frame = CGRectMake(label2.right+5, line1.bottom+20, border.width-label2.right-5, 16);
        [self.contentView addSubview:contact];
        [contact mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label2.mas_right).offset(5);
            make.top.equalTo(line1.mas_bottom).offset(20);
            make.right.equalTo(@(-30));
        }];
        
        UILabel *line2 = [[UILabel alloc] init];
        line2.backgroundColor = RGB(240, 240, 240);
        [self.contentView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@30);
            make.width.equalTo(border);
            make.top.equalTo(contact.mas_bottom).offset(20);
            make.height.equalTo(@1);
        }];
        
        UILabel *label3 = [UILabel labelWithText:@"联系方式:" textColor:RGB(142, 142, 142) fontSize:16];
//        label3.frame = CGRectMake(35, line2.bottom+20, 80, 16);
        [self.contentView addSubview:label3];
        [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@35);
            make.top.equalTo(line2.mas_bottom).offset(20);
            make.width.equalTo(@80);
        }];
        
        UILabel *contactTel = [UILabel labelWithText:@"022-85860201" textColor:RGB(142, 142, 142) fontSize:16];
        self.contactTel = contactTel;
//        contactTel.frame = CGRectMake(label3.right+5, line2.bottom+20, border.width-label3.right-5, 16);
        [self.contentView addSubview:contactTel];
        [contactTel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(label3.mas_right).offset(5);
            make.top.equalTo(line2.mas_bottom).offset(20);
        }];
    }
    return self;
}

@end
