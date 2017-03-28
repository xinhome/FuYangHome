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
        UIImageView *border = [[UIImageView alloc] initWithFrame:CGRectMake(30, 0, kScreenWidth-40, 175)];
        self.border = border;
        border.highlightedImage = [UIImage imageNamed:@"dizhikuang"];
        border.image = UIImageNamed(@"灰框");
        [self.contentView addSubview:border];
        
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        iv.hidden = YES;
        self.iv = iv;
        iv.highlightedImage = UIImageNamed(@"selected");
        iv.image = UIImageNamed(@"unselect");
        [self.contentView addSubview:iv];
        
        UILabel *label1 = [UILabel labelWithText:@"收货地址:" textColor:RGB(142, 142, 142) fontSize:16];
        label1.frame = CGRectMake(35, 20, 80, 16);
        [self.contentView addSubview:label1];
        
        UILabel *address = [UILabel labelWithText:@"天津市河西区富力中心大厦B座21层" textColor:RGB(142, 142, 142) fontSize:16];
        self.address = address;
        CGSize strSize = [@"天津市河西区富力中心大厦B座21层" getSizeWithMaxSize:CGSizeMake(border.width-label1.right-5, 40) attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:16]}];
        address.numberOfLines = 0;
//        address.lineBreakMode = NSLineBreakByCharWrapping;
        address.frame = CGRectMake(label1.right+5, 20, strSize.width, strSize.height);
        [self.contentView addSubview:address];
        
        UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(30, address.bottom+5, border.width, 1)];
        line1.backgroundColor = RGB(240, 240, 240);
        [self.contentView addSubview:line1];
        
        UILabel *label2 = [UILabel labelWithText:@"收货人:" textColor:RGB(142, 142, 142) fontSize:16];
        label2.frame = CGRectMake(35, line1.bottom+20, 55, 16);
        [self.contentView addSubview:label2];
        
        UILabel *contact = [UILabel labelWithText:@"李先生" textColor:RGB(142, 142, 142) fontSize:16];
        self.contact = contact;
        contact.frame = CGRectMake(label2.right+5, line1.bottom+20, border.width-label2.right-5, 16);
        [self.contentView addSubview:contact];
        
        UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(30, contact.bottom+20, border.width, 1)];
        line2.backgroundColor = RGB(240, 240, 240);
        [self.contentView addSubview:line2];
        
        UILabel *label3 = [UILabel labelWithText:@"联系方式:" textColor:RGB(142, 142, 142) fontSize:16];
        label3.frame = CGRectMake(35, line2.bottom+20, 80, 16);
        [self.contentView addSubview:label3];
        
        UILabel *contactTel = [UILabel labelWithText:@"022-85860201" textColor:RGB(142, 142, 142) fontSize:16];
        self.contactTel = contactTel;
        contactTel.frame = CGRectMake(label3.right+5, line2.bottom+20, border.width-label3.right-5, 16);
        [self.contentView addSubview:contactTel];
    }
    return self;
}

@end
