//
//  ProductDetailCell.m
//  家居定制
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 Appcoda. All rights reserved.
//

#import "ProductDetailCell.h"

@implementation ProductDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(24, 24, kScreenWidth-48, rateHeight(440))];
        self.iv = imageView;
//        imageView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imageView];
    }
    return self;
}

@end
