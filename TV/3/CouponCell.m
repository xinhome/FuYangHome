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
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.height.equalTo(self);
            make.width.equalTo(@(rateWidth(300)));
        }];
    }
    return self;
}

@end
