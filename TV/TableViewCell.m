//
//  TableViewCell.m
//  view
//
//  Created by iKing on 2017/3/21.
//  Copyright © 2017年 iKing. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 34, 34)];
        [self.contentView addSubview:iv];
    }
    return self;
}

@end
